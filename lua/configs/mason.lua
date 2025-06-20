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
---@field lsps string[]?
---@field daps string[]
---@field linters string[]?
---@field formatters string[]?

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
  local lspconfig_exists, _ = pcall(require, "lspconfig")
  local lint_exists, lint = pcall(require, "lint")
  local conform_exists, conform = pcall(require, "conform")
  local registry = require("mason-registry")
  local mason_names = iter(registry.get_all_package_specs())
    :filter(function(pkg_spec)
      return vim.tbl_get(pkg_spec, "neovim", "lspconfig") ~= nil
    end)
    :fold({}, function(acc, pkg_spec)
      acc[pkg_spec.neovim.lspconfig] = pkg_spec.name
      return acc
    end)

  return {
    lsps = lspconfig_exists and iter(vim.tbl_keys(vim.lsp._enabled_configs))
      :map(function(lspcfg_name)
        return mason_names[lspcfg_name] or lspcfg_name
      end)
      :totable() or nil,
    daps = require("configs.nvim-dap").adapters,
    linters = lint_exists and iter(vim.tbl_values(lint.linters_by_ft))
      :flatten()
      :map(function(lnt)
        return lint.linters[lnt].cmd
      end)
      :totable() or nil,
    formatters = conform_exists and iter(conform.list_all_formatters())
      :map(function(fmt)
        return fmt.command
      end)
      :totable() or nil,
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
