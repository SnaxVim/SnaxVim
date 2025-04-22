local options = {
  completion = {
    list = { selection = { auto_insert = false } },
    documentation = {
      auto_show = true,
      window = { border = "rounded" },
    },
    ghost_text = { enabled = true },
  },
  keymap = { preset = "super-tab" },
  sources = {
    default = {
      "buffer",
      "lsp",
      "path",
    },
    min_keyword_length = function(args)
      if args.mode == "cmdline" and args.line:find("^%l+$") ~= nil then
        return 2
      end
      return 0
    end,
  },
  cmdline = {
    keymap = { preset = "super-tab" },
    completion = {
      list = { selection = { auto_insert = false } },
      menu = { auto_show = true },
    },
  },
}

return options
