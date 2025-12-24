local api = vim.api
local iter = vim.iter
local tbl_get = vim.tbl_get
local tbl_keys = vim.tbl_keys
local augroup = "mason-install-packages"

--- Install packages that are not yet installed via mason.nvim
---@param packages string[]
---@param has_package function
---@param get_package function
local function install_pkgs(packages, has_package, get_package)
  iter(packages)
    :filter(function(pkg)
      return has_package(pkg)
    end)
    :map(get_package)
    :filter(function(pkg)
      return not pkg:is_installed()
    end)
    :each(function(pkg)
      pkg:install()
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
  return tbl_keys(iter({ pkgs.lsps, pkgs.daps, pkgs.linters, pkgs.formatters }):flatten():fold({}, function(acc, pkg)
    acc[pkg] = true
    return acc
  end))
end

--- Extract installable package names from current plugin configurations
---@param mason_lspconfig_table table<string, string>
---@param mason_bin_table table<string, string>
---@return PkgLists
local function extract_pkgname_lists(mason_lspconfig_table, mason_bin_table)
  local ok_lspconfig, _ = pcall(require, "lspconfig")
  local ok_dapcfg, dapcfg = pcall(require, "configs.nvim-dap")
  local ok_lint, lint = pcall(require, "lint")
  local ok_conform, conform = pcall(require, "conform")

  return {
    lsps = ok_lspconfig and iter(tbl_keys(vim.lsp._enabled_configs))
      :map(function(lspcfg_name)
        return mason_lspconfig_table[lspcfg_name]
      end)
      :totable() or {},
    daps = ok_dapcfg and dapcfg.adapters or {},
    linters = ok_lint and iter(vim.tbl_values(lint.linters_by_ft))
      :flatten()
      :filter(function(lnt)
        return tbl_get(lint, "linters") ~= nil and type(lint.linters[lnt]) == "table"
      end)
      :map(function(lnt)
        local cmd = lint.linters[lnt].cmd
        local cmd_fn = type(cmd) == "function" and cmd() or cmd
        return mason_bin_table[cmd_fn]
      end)
      :totable() or {},
    formatters = (ok_conform and type(conform.list_all_formatters) == "function")
        and iter(conform.list_all_formatters() or {})
          :map(function(fmt)
            return { mason_bin_table[fmt.name], mason_bin_table[fmt.command] }
          end)
          :flatten()
          :totable()
      or {},
  }
end

--- Create a mapping table from each nvim-lspconfig name to its mason-registry package name
---@param all_pkg_specs RegistryPackageSpec[]
---@return table<string, string>
local function create_mason_lspconfig_table(all_pkg_specs)
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

--- Create a mapping table from each binary name to its mason-registry package name
---@param all_pkg_specs RegistryPackageSpec[]
---@return table<string, string>
local function create_mason_bin_table(all_pkg_specs)
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

api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup(augroup, { clear = true }),
  once = true,
  pattern = "mason",
  callback = function()
    local registry = require("mason-registry")
    local has_package = registry.has_package
    local get_package = registry.get_package
    if type(has_package) == "function" and type(get_package) == "function" then
      local ok_get_all_pkg_specs, all_pkg_specs = pcall(registry.get_all_package_specs)
      if not ok_get_all_pkg_specs then
        vim.notify("Failed to load package metadata from mason-registry.", vim.log.levels.WARN)
      end
      local mason_lspconfig_table = ok_get_all_pkg_specs and create_mason_lspconfig_table(all_pkg_specs) or {}
      local mason_bin_table = ok_get_all_pkg_specs and create_mason_bin_table(all_pkg_specs) or {}

      local pkgs = extract_pkgname_lists(mason_lspconfig_table, mason_bin_table)
      pcall(registry.refresh, install_pkgs(merge_uniq_pkgnames(pkgs), has_package, get_package))
    end
  end,
})
