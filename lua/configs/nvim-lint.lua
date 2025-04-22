local function config()
  -- Map each filetype to a list of the config filenames to set up linters (NOT the Mason package name)
  -- See available filenames: https://github.com/mfussenegger/nvim-lint/tree/master/lua/lint/linters
  require("lint").linters_by_ft = {
    -- python = { "ruff" },
  }

  require("autocmds.nvim-lint")
end

return config
