local map = vim.keymap.set
map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "Conform Format" })
