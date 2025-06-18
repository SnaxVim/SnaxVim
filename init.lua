require("options_pre")
require("configs.lazy")

vim.schedule(function()
  require("options")
  require("keymaps")
end)
