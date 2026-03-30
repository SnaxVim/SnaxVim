local function config()
  if vim.uv.os_uname().sysname == "Windows_NT" and vim.fn.executable("cl") == 0 then
    local env = vim.env
    env.CC = env.CC or "gcc"
  end

  require("autocmds.nvim-treesitter")
end

return config
