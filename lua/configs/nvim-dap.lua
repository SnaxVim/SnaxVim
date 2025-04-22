local M = {}

-- Specify Mason package names for debug adapters to install
M.adapters = {
  -- "debugpy",
}

function M.config()
  local dap = require("dap")

  local dv_exists, dv = pcall(require, "dap-view")
  if dv_exists then
    dap.listeners.after.event_initialized["dap-view-config"] = dv.open
    dap.listeners.before.event_terminated["dap-view-config"] = dv.close
    dap.listeners.before.event_exited["dap-view-config"] = dv.close
  end

  local sign_define = vim.fn.sign_define
  sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", numhl = "DiagnosticError" })
  sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticError", numhl = "DiagnosticError" })
  sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", numhl = "DiagnosticError" })
  sign_define("DapLogPoint", { text = "", texthl = "DiagnosticError", numhl = "DiagnosticError" })
  sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn", numhl = "DiagnosticWarn" })
end

return M
