-- This sample shows how to add plugins in the expected format; any file in this directory can do the same
-- Consider moving `opts` and `config` into `lua/configs` and requiring them here for better organization

return {
  -- { -- Colorscheme
  --   "catppuccin/nvim",
  --   lazy = false,
  --   config = function()
  --     require("catppuccin").setup({ no_italic = true })
  --     vim.cmd.colorscheme("catppuccin-latte")
  --   end,
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
