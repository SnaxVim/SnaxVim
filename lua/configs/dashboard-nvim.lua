local function config()
  local version = vim.version()
  local header_title = " neovim v" .. version.major .. "." .. version.minor .. "." .. version.patch
  local header = header_title
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
        { icon = " ", desc = " New File", key = "n", action = "ene | start" },
        { icon = "󱋢 ", desc = " Recent Files", key = "r", action = "bro o" },
        {
          icon = " ",
          icon_hl = "DiagnosticInfo",
          desc = " Configure LSP (nvim-lspconfig)",
          key = "1",
          action = "e " .. vim.fn.stdpath("config") .. "/lua/configs/nvim-lspconfig.lua",
        },
        {
          icon = " ",
          icon_hl = "DiagnosticInfo",
          desc = " Configure DAP (nvim-dap)",
          key = "2",
          action = "e " .. vim.fn.stdpath("config") .. "/lua/configs/nvim-dap.lua",
        },
        {
          icon = "󱇮 ",
          icon_hl = "DiagnosticInfo",
          desc = " Configure Linter (nvim-lint)",
          key = "3",
          action = "e " .. vim.fn.stdpath("config") .. "/lua/configs/nvim-lint.lua",
        },
        {
          icon = "󰁨 ",
          icon_hl = "DiagnosticInfo",
          desc = " Configure Formatter (conform.nvim)",
          key = "4",
          action = "e " .. vim.fn.stdpath("config") .. "/lua/configs/conform.lua",
        },
        {
          icon = " ",
          icon_hl = "DiagnosticInfo",
          desc = " Manage Plugins",
          key = "p",
          action = "e " .. vim.fn.stdpath("config") .. "/lua/plugins/example.lua",
        },
        { icon = "󰟾 ", icon_hl = "DiagnosticHint", desc = " Mason", key = "m", action = "Mason" },
        { icon = "󰒲 ", icon_hl = "DiagnosticHint", desc = " Lazy", key = "l", action = "Lazy" },
        { icon = " ", desc = " Quit", key = "q", action = "qa" },
      },
      vertical_center = true,
    },
  }

  return options
end

return config
