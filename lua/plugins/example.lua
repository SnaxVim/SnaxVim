-- Example plugin definitions
-- Uncomment an example or add a new plugin below
-- You can split plugin definitions into multiple files in this directory

return {
  { -- Dashboard
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = require("configs.dashboard-nvim"),
  },

  -- { -- Colorscheme
  --   "catppuccin/nvim",
  --   lazy = false,
  --   config = function()
  --     require("catppuccin").setup({ no_italic = true })
  --     vim.cmd.colorscheme("catppuccin-latte")
  --   end,
  -- },

  -- { -- Fuzzy finder
  --   "nvim-telescope/telescope.nvim",
  --   cmd = "Telescope",
  -- },

  -- { -- Git integration for buffers
  --   "lewis6991/gitsigns.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },

  -- { -- Configurations of nvim-dap for python
  --   "mfussenegger/nvim-dap-python",
  --   ft = "python",
  --   config = function()
  --     local venv_bin_dirname = vim.uv.os_uname().sysname == "Windows_NT" and "Scripts" or "bin"
  --     local python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/" .. venv_bin_dirname .. "/python"
  --     require("dap-python").setup(python)
  --   end,
  -- },
}
