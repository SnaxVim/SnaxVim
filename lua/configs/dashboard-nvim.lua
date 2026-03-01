local version = vim.version()
local version_info = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
local header = " neovim "
  .. version_info
  .. [[

─────────────────────────────────────
Get started with development features

- Press 1–4 to review the setup files
- Restart Neovim                     
- Press m to install packages        
- Press p to manage plugins          

]]

local options = {
  theme = "doom",
  config = {
    header = vim.split(header, "\n"),
    center = {
      { icon = " ", desc = " New File", key = "n", action = "enew | startinsert" },
      { icon = "󱋢 ", desc = " Recent Files", key = "r", action = "browse oldfiles" },
      {
        icon = " ",
        icon_hl = "DiagnosticInfo",
        desc = " Configure LSP (nvim-lspconfig)",
        key = "1",
        action = "lua vim.cmd.edit(vim.fn.stdpath('config') .. '/lua/configs/nvim-lspconfig.lua')",
      },
      {
        icon = " ",
        icon_hl = "DiagnosticInfo",
        desc = " Configure DAP (nvim-dap)",
        key = "2",
        action = "lua vim.cmd.edit(vim.fn.stdpath('config') .. '/lua/configs/nvim-dap.lua')",
      },
      {
        icon = "󱇮 ",
        icon_hl = "DiagnosticInfo",
        desc = " Configure Linter (nvim-lint)",
        key = "3",
        action = "lua vim.cmd.edit(vim.fn.stdpath('config') .. '/lua/configs/nvim-lint.lua')",
      },
      {
        icon = "󰁨 ",
        icon_hl = "DiagnosticInfo",
        desc = " Configure Formatter (conform.nvim)",
        key = "4",
        action = "lua vim.cmd.edit(vim.fn.stdpath('config') .. '/lua/configs/conform.lua')",
      },
      {
        icon = " ",
        icon_hl = "DiagnosticInfo",
        desc = " Manage Plugins",
        key = "p",
        action = "lua vim.cmd.edit(vim.fn.stdpath('config') .. '/lua/plugins/example.lua')",
      },
      { icon = "󰟾 ", icon_hl = "DiagnosticHint", desc = " Mason", key = "m", action = "Mason" },
      { icon = "󰒲 ", icon_hl = "DiagnosticHint", desc = " Lazy", key = "l", action = "Lazy" },
      { icon = " ", desc = " Quit", key = "q", action = "qa" },
    },
    vertical_center = true,
  },
}

return options
