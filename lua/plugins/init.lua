return {
  { -- Collection of QoL plugins
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("configs.snacks"),
  },

  { -- Parser
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufNewFile", "BufReadPost" },
    config = require("configs.nvim-treesitter"),
  },

  { -- Completion
    "saghen/blink.cmp",
    version = "*",
    event = { "CmdLineEnter", "InsertEnter" },
    opts = require("configs.blink"),
  },

  { -- Portable package manager for LSP, DAP, linters, and formatters
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    event = { "BufNewFile", "BufReadPost" },
    opts = require("configs.mason"),
  },
  { -- Configs for LSP
    "neovim/nvim-lspconfig",
    event = { "BufAdd", "BufNewFile", "BufReadPre" },
    config = require("configs.nvim-lspconfig"),
  },
  { -- DAP client
    "mfussenegger/nvim-dap",
    dependencies = "igorlfs/nvim-dap-view",
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    config = require("configs.nvim-dap").config,
  },
  { -- Visualize debugging sessions
    "igorlfs/nvim-dap-view",
    cmd = "DapViewToggle",
    opts = require("configs.nvim-dap-view"),
  },
  { -- Linter
    "mfussenegger/nvim-lint",
    event = { "BufNewFile", "BufReadPre", "BufWritePost" },
    config = require("configs.nvim-lint"),
  },
  { -- Formatter
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require("configs.conform"),
  },
}
