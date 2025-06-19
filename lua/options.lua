local env = vim.env
local sep = vim.uv.os_uname().sysname == "Windows_NT" and ";" or ":"
local o = vim.o
local opt = vim.opt

-- environment variables defined in the editor session
env.PATH = table.concat({
  env.PATH,
  vim.fn.stdpath("data") .. "/mason/bin",
}, sep)

-- editor options
o.confirm = true
o.expandtab = true
o.shiftwidth = 0
o.tabstop = 2
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.ignorecase = true
o.smartcase = true
opt.listchars = { tab = " ‥", trail = "-", nbsp = "␣", eol = "↲", space = "·", extends = "»", precedes = "«" }
o.mouse = "a"
o.scrolloff = 5
o.smartindent = true
o.splitbelow = true
o.splitright = true
o.undofile = true
o.whichwrap = "b,s,<,>,[,]"
o.wrap = false
