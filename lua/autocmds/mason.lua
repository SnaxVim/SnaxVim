local api = vim.api
local iter = vim.iter
local tbl_get = vim.tbl_get
local tbl_keys = vim.tbl_keys

--- Build a lookup table from nvim-lspconfig names to mason package names
---@param all_pkg_specs RegistryPackageSpec[]
---@return table<string, string>
local function build_lspconfig_to_mason_pkg(all_pkg_specs)
  return iter(all_pkg_specs)
    :filter(function(pkg_spec)
      return tbl_get(pkg_spec, "neovim") ~= nil
        and type(pkg_spec.neovim.lspconfig) == "string"
        and type(pkg_spec.name) == "string"
    end)
    :fold({}, function(acc, pkg_spec)
      acc[pkg_spec.neovim.lspconfig] = pkg_spec.name
      return acc
    end)
end

--- Build a lookup table from binary names to mason package names
---@param all_pkg_specs RegistryPackageSpec[]
---@return table<string, string>
local function build_bin_to_mason_pkg(all_pkg_specs)
  return iter(all_pkg_specs)
    :filter(function(pkg_spec)
      return type(pkg_spec.bin) == "table" and type(pkg_spec.name) == "string"
    end)
    :fold({}, function(acc, pkg_spec)
      iter(tbl_keys(pkg_spec.bin)):each(function(bin)
        acc[bin] = pkg_spec.name
      end)
      return acc
    end)
end

--- Safely require a module and return nil if unavailable
---@param modname string
---@return table?
local function safe_require(modname)
  local ok, module = pcall(require, modname)
  if ok then
    return module
  end
  return nil
end

---@class PkgLists
---@field lsps string[]
---@field daps string[]
---@field linters string[]
---@field formatters string[]

--- Extract mason package names from current plugin configurations
---@param lspconfig_to_pkg table<string, string>
---@param bin_to_pkg table<string, string>
---@param ok_lspconfig boolean
---@param dapcfg table?
---@param lint table?
---@param conform table?
---@return PkgLists
local function extract_pkgname_lists(lspconfig_to_pkg, bin_to_pkg, ok_lspconfig, dapcfg, lint, conform)
  return {
    lsps = ok_lspconfig and iter(tbl_keys(vim.lsp._enabled_configs))
      :map(function(lspcfg_name)
        return lspconfig_to_pkg[lspcfg_name]
      end)
      :totable() or {},
    daps = dapcfg and dapcfg.adapters or {},
    linters = lint and iter(vim.tbl_values(lint.linters_by_ft))
      :flatten()
      :filter(function(lnt)
        return tbl_get(lint, "linters") ~= nil and type(lint.linters[lnt]) == "table"
      end)
      :map(function(lnt)
        local cmd = lint.linters[lnt].cmd
        local cmd_fn = type(cmd) == "function" and cmd() or cmd
        return bin_to_pkg[cmd_fn]
      end)
      :totable() or {},
    formatters = (conform and type(conform.list_all_formatters) == "function")
        and iter(conform.list_all_formatters() or {})
          :map(function(fmt)
            return { bin_to_pkg[fmt.name], bin_to_pkg[fmt.command] }
          end)
          :flatten()
          :totable()
      or {},
  }
end

--- Resolve declared package names into a flattened, deduplicated list of packages not yet available in the system
---@param pkglists PkgLists
---@param registry table
---@return string[]
local function resolve_missing_pkgnames(pkglists, registry)
  local has_package = registry.has_package
  local is_installed = registry.is_installed

  if type(has_package) == "function" and type(is_installed) == "function" then
    return tbl_keys(iter({ pkglists.lsps, pkglists.daps, pkglists.linters, pkglists.formatters })
      :flatten()
      :filter(function(pkg)
        return has_package(pkg) and not is_installed(pkg) and vim.fn.executable(pkg) == 0
      end)
      :fold({}, function(acc, pkg)
        acc[pkg] = true
        return acc
      end))
  end

  return {}
end

--- Return a single-line prompt listing missing tools
---@param packages string[]
---@return string
local function missing_tools_prompt(packages)
  local display_limit = 5
  local body = table.concat(iter(packages):take(display_limit):totable(), ", ")
  local suffix = #packages > display_limit and string.format(", … (+%d more)", #packages - display_limit) or ""

  return "Missing tools: " .. body .. suffix
end

api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("mason-install-packages", { clear = true }),
  once = true,
  pattern = "mason",
  callback = function()
    local registry = require("mason-registry")

    pcall(registry.refresh, function()
      local ok_all_pkg_specs, all_pkg_specs = pcall(registry.get_all_package_specs)

      if ok_all_pkg_specs then
        local lspconfig_to_pkg = build_lspconfig_to_mason_pkg(all_pkg_specs)
        local bin_to_pkg = build_bin_to_mason_pkg(all_pkg_specs)

        local ok_lspconfig, _ = pcall(require, "lspconfig")
        local dapcfg = safe_require("configs.nvim-dap")
        local lint = safe_require("lint")
        local conform = safe_require("conform")

        local pkglists = extract_pkgname_lists(lspconfig_to_pkg, bin_to_pkg, ok_lspconfig, dapcfg, lint, conform)
        local pkgs = resolve_missing_pkgnames(pkglists, registry)

        if not vim.tbl_isempty(pkgs) then
          vim.ui.select({ true, false }, {
            prompt = missing_tools_prompt(pkgs),
            format_item = function(item)
              return item and "Install" or "Skip"
            end,
          }, function(choice)
            local get_package = registry.get_package
            if choice and type(get_package) == "function" then
              iter(pkgs):map(get_package):each(function(pkg)
                pkg:install()
              end)
            end
          end)
        end
      else
        vim.notify("Failed to load package metadata from mason-registry.", vim.log.levels.WARN)
      end
    end)
  end,
})
