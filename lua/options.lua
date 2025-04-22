local g = vim.g
local o = vim.o
local opt = vim.opt

-- global variables
g.mapleader = " "

-- behaves like :set
o.confirm = true
o.cursorline = true
o.expandtab = true
o.shiftwidth = 0
o.tabstop = 2
opt.fillchars = { eob = " ", foldclose = "", foldopen = "", foldsep = " " }
o.foldcolumn = "1"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99
o.foldmethod = "expr"
o.foldtext = ""
o.signcolumn = "yes"
o.statuscolumn = "%s%l%#FoldColumn#%{v:lua.require('foldcolumn')()} %*"
o.ignorecase = true
o.smartcase = true
o.laststatus = 3
o.list = true
opt.listchars = { tab = " ‥", trail = "-", nbsp = "␣", eol = "↲", space = "·", extends = "»", precedes = "«" }
o.mouse = "a"
o.number = true
o.relativenumber = true
o.scrolloff = 5
o.smartindent = true
o.splitbelow = true
o.splitright = true
o.undofile = true
o.whichwrap = "b,s,<,>,[,]"
o.wrap = false
