local api = vim.api
api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged" }, {
  group = api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function()
    if vim.bo.modifiable then
      require("lint").try_lint()
    end
  end,
})
