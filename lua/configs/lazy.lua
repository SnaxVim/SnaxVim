local options = {
  defaults = { lazy = true },
  spec = { import = "plugins" },
  install = { colorscheme = { "default" } },
  ui = { icons = { loaded = "󰄳", not_loaded = "󰄰" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}

local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(options)
