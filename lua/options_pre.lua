local g = vim.g
local o = vim.o
local opt = vim.opt

g.mapleader = " "

o.cursorline = true
opt.fillchars = { eob = " ", foldclose = "", foldopen = "", foldsep = " ", foldinner = " " }
o.foldcolumn = "1"
o.signcolumn = "yes"
o.laststatus = 3
o.list = true
o.number = true
o.relativenumber = true
