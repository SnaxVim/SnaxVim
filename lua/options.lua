local env = vim.env
local o = vim.o
local opt = vim.opt
local diagnostic = vim.diagnostic
local sev = diagnostic.severity

-- environment variables defined in the editor session
env.PATH = table.concat({
  env.PATH,
  vim.fn.stdpath("data") .. "/mason/bin",
}, vim.uv.os_uname().sysname == "Windows_NT" and ";" or ":")

-- editor options
o.confirm = true
o.expandtab = true
o.shiftwidth = 0
o.tabstop = 2
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

-- diagnostic options
diagnostic.config({
  float = { border = "rounded" },
  signs = { text = { [sev.ERROR] = "󰅚", [sev.WARN] = "󰀪", [sev.INFO] = "󰋽", [sev.HINT] = "󰌶" } },
  virtual_text = true,
})
