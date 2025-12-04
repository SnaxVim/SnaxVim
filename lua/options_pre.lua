local g = vim.g
local o = vim.o
local opt = vim.opt

g.mapleader = " "

o.cursorline = true
opt.fillchars = { eob = " ", foldclose = "", foldopen = "", foldsep = " " }
o.foldlevel = 99
o.foldmethod = "expr"
o.foldtext = ""
o.laststatus = 3
o.list = true
o.number = true
o.relativenumber = true
