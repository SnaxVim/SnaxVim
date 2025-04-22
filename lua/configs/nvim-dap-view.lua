local options = {
  winbar = {
    sections = {
      "console",
      "watches",
      "scopes",
      "exceptions",
      "breakpoints",
      "threads",
      "repl",
    },
    default_section = "console",
    controls = {
      enabled = true,
      position = "left",
    },
  },
}

return options
