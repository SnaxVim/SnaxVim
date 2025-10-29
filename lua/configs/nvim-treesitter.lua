if vim.uv.os_uname().sysname == "Windows_NT" and vim.fn.executable("cl") == 0 then
  vim.env.CC = "gcc"
end

local function config()
  require("autocmds.nvim-treesitter")
end

return config
