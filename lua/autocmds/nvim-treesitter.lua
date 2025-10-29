local api = vim.api
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("ts-start", {}),
  callback = function(args)
    local treesitter = vim.treesitter
    local contains = vim.list_contains
    local ts = require("nvim-treesitter")

    local ok_lang, lang = pcall(treesitter.language.get_lang, args.match)
    if ok_lang then
      if contains(ts.get_available(), lang) and not contains(ts.get_installed(), lang) then
        ts.install(lang)
      end
    end

    pcall(treesitter.start)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  end,
})
