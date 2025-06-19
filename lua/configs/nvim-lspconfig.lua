local function config()
  local lsp = vim.lsp

  -- Specify the config filenames to set up language servers (NOT the Mason package name)
  -- See available filenames: https://github.com/neovim/nvim-lspconfig/tree/master/lsp
  local servers = {
    -- "lua_ls",
    -- "basedpyright",
  }

  -- Override the default configuration for specific language servers
  -- lsp.config("lua_ls", {
  --   settings = {
  --     Lua = {
  --       runtime = { version = "LuaJIT", pathStrict = true },
  --       workspace = {
  --         library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
  --           "${3rd}/luv/library",
  --         }),
  --       },
  --     },
  --   },
  -- })
  -- lsp.config("basedpyright", {
  --   settings = {
  --     basedpyright = {
  --       analysis = {
  --         typeCheckingMode = "off",
  --       },
  --     },
  --   },
  -- })

  lsp.inlay_hint.enable(true)

  if next(servers) then
    lsp.enable(servers)
  end
end

return config
