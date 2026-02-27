local function config()
  require("autocmds.mason")

  local options = {
    ui = { icons = { package_pending = "󰦗", package_installed = "󰄳", package_uninstalled = "󰄰" } },
  }

  return options
end

return config
