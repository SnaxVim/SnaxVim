local api = vim.api
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("ts-start", { clear = true }),
  callback = function(args)
    local ts = require("nvim-treesitter")
    local ok_available, available_langs = pcall(ts.get_available)

    local treesitter = vim.treesitter
    local ok_lang, lang = pcall(treesitter.language.get_lang, args.match)

    local tbl_contains = vim.tbl_contains
    if ok_available and ok_lang and tbl_contains(available_langs, lang) then
      local ok_installed, installed_langs = pcall(ts.get_installed)
      if ok_installed and not tbl_contains(installed_langs, lang) then
        pcall(ts.install, lang)
      end

      pcall(treesitter.start)

      local wo = vim.wo
      wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      wo.foldlevel = 99
      wo.foldmethod = "expr"
      wo.foldtext = ""
      vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end
  end,
})
