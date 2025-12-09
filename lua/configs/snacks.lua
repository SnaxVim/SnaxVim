local version = vim.version()
local version_info = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
local header = " neovim "
  .. version_info
  .. [[

───────────────────────────────────────────────
Follow these steps to enable IDE-like features:

1. Press c and read the comments in these files
   - lua/configs/nvim-lspconfig.lua            
   - lua/configs/nvim-dap.lua                  
   - lua/configs/nvim-lint.lua                 
   - lua/configs/conform.lua                   

2. Restart Neovim                              

3. Press M and wait for the packages to install

4. Edit lua/plugins/example.lua to add plugins ]]

local options = {
  dashboard = {
    preset = {
      keys = {
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = "󰙅 ", key = "e", desc = "Explorer", action = ":lua Snacks.dashboard.pick('explorer')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
        { icon = "󰟾 ", key = "M", desc = "Mason", action = ":lua require('mason.ui').open()" },
        { icon = " ", key = "m", desc = "Keymaps", action = ":lua Snacks.dashboard.pick('keymaps')" },
        {
          icon = " ",
          key = "c",
          desc = "Config",
          action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
        },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
      header = header,
    },
  },
  statuscolumn = {
    folds = {
      open = true,
      git_hl = true,
    },
    refresh = 1,
  },
  styles = {
    terminal = {
      keys = {
        term_normal = false,
      },
    },
  },
}

return options
