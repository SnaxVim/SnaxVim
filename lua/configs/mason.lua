local function pkg_install()
  local iter = vim.iter
  local tbl_keys = vim.tbl_keys
  local registry = require("mason-registry")

  local mason_names = iter(registry.get_all_package_specs())
    :filter(function(pkg_spec)
      return vim.tbl_get(pkg_spec, "neovim", "lspconfig") ~= nil
    end)
    :fold({}, function(acc, pkg_spec)
      acc[pkg_spec.neovim.lspconfig] = pkg_spec.name
      return acc
    end)

  local lspconfig_exists, _ = pcall(require, "lspconfig")
  local lsps = lspconfig_exists
      and iter(tbl_keys(vim.lsp._enabled_configs))
        :map(function(lspcfg_name)
          return mason_names[lspcfg_name] or lspcfg_name
        end)
        :totable()
    or {}

  local daps = require("configs.nvim-dap").adapters

  local lint_exists, lint = pcall(require, "lint")
  local linters = lint_exists
      and iter(vim.tbl_values(lint.linters_by_ft))
        :flatten()
        :map(function(lnt)
          return lint.linters[lnt].cmd
        end)
        :totable()
    or {}

  local conform_exists, conform = pcall(require, "conform")
  local formatters = conform_exists
      and iter(conform.list_all_formatters())
        :map(function(fmt)
          return fmt.command
        end)
        :totable()
    or {}

  -- Merge and deduplicate
  local packages = tbl_keys(iter({ lsps, daps, linters, formatters }):flatten():fold({}, function(acc, pkg)
    acc[pkg] = true
    return acc
  end))

  -- Install packages
  registry.refresh(function()
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

local function config()
  local options = {
    ui = { icons = { package_pending = "󰦗", package_installed = "󰄳", package_uninstalled = "󰄰" } },
  }

  require("mason").setup(options)

  if vim.v.vim_did_enter == 1 then
    pkg_install()
  end
end

return config
