local function config()
  if vim.uv.os_uname().sysname == "Windows_NT" and vim.fn.executable("cl") == 0 then
    vim.env.CC = "gcc"
  end

  require("autocmds.nvim-treesitter")
end

return config
