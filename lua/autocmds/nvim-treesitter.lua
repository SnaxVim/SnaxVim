local api = vim.api
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("ts-start", { clear = true }),
  pattern = (function()
    local ok, tbl = pcall(require("nvim-treesitter").get_available)
    return ok and tbl or "__never_match__"
  end)(),
  callback = function(args)
    local treesitter = vim.treesitter
    local ok_lang, lang = pcall(treesitter.language.get_lang, args.match)
    if ok_lang then
      local ts = require("nvim-treesitter")
      local ok_installed, installed = pcall(ts.get_installed)
      if ok_installed and not vim.tbl_contains(installed, lang) then
        pcall(ts.install, lang)
      end
    end

    pcall(treesitter.start)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  end,
})
