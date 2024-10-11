-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "#2e3440" }) -- 替换为你想要的颜色

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.buflist_cache = {}

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 24-bit colors
vim.opt.termguicolors = true
vim.g.lazydev_enabled = true
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.g.markdown_fenced_languages = {
	"ts=typescript",
}

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
-- 设置分隔符颜色
