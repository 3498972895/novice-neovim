local C = {}
C.error = vim.api.nvim_get_hl_by_name("DiagnosticSignError", true).foreground
C.warn = vim.api.nvim_get_hl_by_name("DiagnosticSignWarn", true).foreground
C.info = vim.api.nvim_get_hl_by_name("DiagnosticSignInfo", true).foreground
C.hint = vim.api.nvim_get_hl_by_name("DiagnosticSignHint", true).foreground
C.status_line = "#0A2A3F"
C.git_branch_fg = "orange"

C.diff_add = "red"
-- C.hint = vim.api.nvim_get_hl_by_name("DiagnosticSignHint", true).foreground
-- C.hint = vim.api.nvim_get_hl_by_name("DiagnosticSignHint", true).foreground
return C
