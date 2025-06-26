local options = {
  -- Map each filetype to a list of the config filenames to set up formatters (NOT the Mason package name)
  -- See available filenames: https://github.com/stevearc/conform.nvim/tree/master/lua/conform/formatters
  formatters_by_ft = {
    -- lua = { "stylua" },
    -- python = { "ruff_format", "ruff_organize_imports" },
  },

  -- Override the default configuration for specific formatters
  formatters = {
    -- stylua = {
    --   prepend_args = {
    --     "--column-width=120",
    --     "--indent-type=Spaces",
    --     "--indent-width=2",
    --     "--line-endings=Unix",
    --   },
    -- },
    -- ruff_format = {
    --   append_args = {
    --     "--line-length=88",
    --   },
    -- },
  },

  format_on_save = function()
    return vim.v.cmdbang ~= 1 and {} -- Skip formatting when saving with a bang (e.g. `:w!`, `:up!`)
  end,

  default_format_opts = {
    lsp_format = "fallback",
    timeout_ms = 3000,
  },
}

return options
