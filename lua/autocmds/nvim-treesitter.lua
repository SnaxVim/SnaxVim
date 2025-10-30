local api = vim.api
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("ts-start", { clear = true }),
  pattern = require("nvim-treesitter").get_available(),
  callback = function(args)
    local treesitter = vim.treesitter
    local ok_lang, lang = pcall(treesitter.language.get_lang, args.match)
    if ok_lang then
      local ts = require("nvim-treesitter")
      if not vim.list_contains(ts.get_installed(), lang) then
        ts.install(lang)
      end
    end

    pcall(treesitter.start)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  end,
})
