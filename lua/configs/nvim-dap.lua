local M = {}

-- Specify Mason package names for debug adapters to install
M.adapters = {
  -- "debugpy",
}

function M.config()
  local sign_define = vim.fn.sign_define
  sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", numhl = "DiagnosticError" })
  sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticError", numhl = "DiagnosticError" })
  sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", numhl = "DiagnosticError" })
  sign_define("DapLogPoint", { text = "", texthl = "DiagnosticError", numhl = "DiagnosticError" })
  sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn", numhl = "DiagnosticWarn" })
end

return M
