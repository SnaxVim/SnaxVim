-- Temporary workaround to hide foldcolumn digits; will be removed once the following PR is merged
-- https://github.com/neovim/neovim/pull/17446

local ffi = require("ffi")
ffi.cdef([[
typedef struct {} Error;
typedef struct {} win_T;
typedef struct {
  int start;
  int level;
  int llevel;
  int lines;
} foldinfo_T;
foldinfo_T fold_info(win_T *wp, int lnum);
win_T *find_window_by_handle(int Window, Error *err);
int compute_foldcolumn(win_T *wp, int col);
]])

local function config()
  local win = vim.api.nvim_get_current_win()
  local err = ffi.new("Error")
  local wp = ffi.C.find_window_by_handle(win, err)
  local lnum = vim.v.lnum
  local foldinfo = ffi.C.fold_info(wp, lnum)
  local level = foldinfo.level
  local width = ffi.C.compute_foldcolumn(wp, 0)

  if level == 0 then
    return (" "):rep(width)
  end

  local closed = foldinfo.lines > 0
  local first_level = math.max(1, level - width - (closed and 1 or 0) + 1)
  local fillchars = vim.opt_local.fillchars:get()
  local fold_len = math.min(level, width)
  local fold_str = vim.iter(vim.fn.range(1, fold_len)):fold("", function(acc, col)
    if vim.v.virtnum ~= 0 then
      return acc .. " "
    elseif closed and (col == level or col == width) then
      return acc .. (fillchars.foldclose or "+")
    elseif foldinfo.start == lnum and first_level + col > foldinfo.llevel then
      return acc .. (fillchars.foldopen or "-")
    else
      return acc .. (fillchars.foldsep or "│")
    end
  end)

  return fold_len < width and fold_str .. (" "):rep(width - fold_len) or fold_str
end

return config
