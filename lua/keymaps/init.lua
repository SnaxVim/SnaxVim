local map = vim.keymap.set

-- clipboard
map({ "n", "x" }, "+", '"+', { desc = "Use Clipboard Register" })
map({ "i", "c" }, "<S-Insert>", "<C-r>+", { desc = "Paste from Clipboard" })
map({ "i", "c" }, "<A-p>", '<C-r>"', { desc = "Paste from Buffer" })

-- edit/selection
map("n", "<leader>>", "v>", { desc = "Indent the Line" })
map("x", "<leader>>", ">gv", { desc = "Indent the Block" })
map("n", "<leader><", "v<", { desc = "Dedent the Line" })
map("x", "<leader><", "<gv", { desc = "Dedent the Block" })
map("n", "<A-j>", "<cmd>move .+1<CR>", { desc = "Move Up the Line" })
map("x", "<A-j>", ":move '>+1<CR>gv", { silent = true, desc = "Move Up the Block" })
map("n", "<A-k>", "<cmd>move .-2<CR>", { desc = "Move Down the Line" })
map("x", "<A-k>", ":move '<-2<CR>gv", { silent = true, desc = "Move Down the Block" })
map("n", "<A-a>", "ggVG", { desc = "Select All" })
map("x", "<C-h>", 'y:%s/<C-r>"/', { desc = "Replace Selection" })

-- window
map("n", "<C-h>", "<C-w>h", { desc = "Window Switch Left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window Switch Right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window Switch Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window Switch Up" })
map("n", "<A-Up>", "<C-w>+", { desc = "Window Increase Height" })
map("n", "<A-Down>", "<C-w>-", { desc = "Window Decrease Height" })
map("n", "<A-Right>", "<C-w>>", { desc = "Window Increase Width" })
map("n", "<A-Left>", "<C-w><", { desc = "Window Decrease Width" })

-- buffer operation
map("n", "<C-n>", "<cmd>enew<CR>", { desc = "Buffer New" })
map({ "n", "x", "i" }, "<C-s>", function()
  local api = vim.api
  if api.nvim_buf_get_name(0) == "" then
    local keys = api.nvim_replace_termcodes("<Esc>:w ", true, false, true)
    api.nvim_feedkeys(keys, "n", false)
  else
    vim.cmd.update()
  end
end, { desc = "Buffer Save" })

-- option
map("t", "<Esc>", "<C-\\><C-n><Plug>(TermEsc)", { desc = "Terminal Switch to Normal Mode" })
map("n", "<Plug>(TermEsc)<Esc>", "i<Esc>", { desc = "Terminal Send Esc" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Highlight Clear" })
map("n", "<leader>wt", function()
  local wo = vim.wo
  wo.wrap = not wo.wrap
  vim.notify("wrap: " .. (wo.wrap and "on" or "off"))
end, { desc = "Wrap Toggle" })

-- LSP
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "LSP Add Workspace Folder" })
map("n", "<leader>wl", function()
  vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "LSP Show Workspace Folder List" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "LSP Remove Workspace Folder" })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "LSP Type Definition" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "LSP Jump to Next Diagnostic" })
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "LSP Jump to Previous Diagnostic" })
map("n", "<leader>qf", vim.diagnostic.setloclist, { desc = "LSP Open Diagnostic Quickfix list" })
map("n", "<leader>ci", function()
  local inlay_hint = vim.lsp.inlay_hint
  if inlay_hint.is_enabled() then
    inlay_hint.enable(false)
    vim.notify("inlay hint: off")
  else
    inlay_hint.enable(true)
    vim.notify("inlay hint: on")
  end
end, { desc = "LSP Toggle Inlay Hint" })

-- plugins
require("keymaps.conform")
require("keymaps.nvim-dap")
require("keymaps.nvim-dap-view")
require("keymaps.snacks")
