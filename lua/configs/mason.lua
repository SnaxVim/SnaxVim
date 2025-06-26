--- Install packages that are not yet installed via mason.nvim
---@param packages string[]
local function install_pkgs(packages)
  local registry = require("mason-registry")
  registry.refresh(function()
    local iter = vim.iter
    iter(packages)
      :map(registry.get_package)
      :filter(function(pkg)
        return not pkg:is_installed()
      end)
      :each(function(pkg)
        pkg:install()
      end)
  end)
end

---@class PkgLists
---@field lsps string[]
---@field daps string[]
---@field linters string[]
---@field formatters string[]

--- Merge package name lists and remove duplicates
---@param pkgs PkgLists
---@return string[]
local function merge_uniq_pkgnames(pkgs)
  return vim.tbl_keys(
    vim.iter({ pkgs.lsps, pkgs.daps, pkgs.linters, pkgs.formatters }):flatten():fold({}, function(acc, pkg)
      acc[pkg] = true
      return acc
    end)
  )
end

--- Extract installable package names from current plugin configurations
---@return PkgLists
local function extract_pkgname_lists()
  local iter = vim.iter
  local ok_lspconfig, _ = pcall(require, "lspconfig")
  local ok_dapcfg, dapcfg = pcall(require, "configs.nvim-dap")
  local ok_lint, lint = pcall(require, "lint")
  local ok_conform, conform = pcall(require, "conform")
  local ok_registry, registry = pcall(require, "mason-registry")
  local mason_names = (ok_registry and type(registry.get_all_package_specs) == "function")
      and iter(registry.get_all_package_specs() or {})
        :filter(function(pkg_spec)
          return vim.tbl_get(pkg_spec, "neovim", "lspconfig") ~= nil
        end)
        :fold({}, function(acc, pkg_spec)
          acc[pkg_spec.neovim.lspconfig] = pkg_spec.name or pkg_spec.neovim.lspconfig
          return acc
        end)
    or {}

  return {
    lsps = ok_lspconfig and iter(vim.tbl_keys(vim.lsp._enabled_configs))
      :map(function(lspcfg_name)
        return mason_names[lspcfg_name] or lspcfg_name
      end)
      :totable() or {},
    daps = ok_dapcfg and dapcfg.adapters or {},
    linters = ok_lint and iter(vim.tbl_values(lint.linters_by_ft))
      :flatten()
      :filter(function(lnt)
        return vim.tbl_get(lint, "linters", lnt) ~= nil
      end)
      :map(function(lnt)
        return lint.linters[lnt].cmd
      end)
      :totable() or {},
    formatters = (ok_conform and type(conform.list_all_formatters) == "function")
        and iter(conform.list_all_formatters() or {})
          :map(function(fmt)
            return fmt.command
          end)
          :totable()
      or {},
  }
end

local function config()
  local options = {
    ui = { icons = { package_pending = "󰦗", package_installed = "󰄳", package_uninstalled = "󰄰" } },
  }

  require("mason").setup(options)

  if vim.v.vim_did_enter == 1 then
    install_pkgs(merge_uniq_pkgnames(extract_pkgname_lists()))
  end
end

return config
