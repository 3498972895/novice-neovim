local M = {}
M.git_symbols = {
	icon = {
		-- Change type
		added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
		modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
		deleted = "", -- this can only be used in the git_status source
		renamed = "➜", -- this can only be used in the git_status source
		-- Status type
		untracked = "★",
		ignored = "◌",
		unstaged = "✗",
		staged = "✓",
		conflict = "",
	},
	character = {
		added = "[+]", -- or "✚", but this is redundant info if you use git_status_colors on the name
		modified = "[M]", -- or "", but this is redundant info if you use git_status_colors on the name
		deleted = "[-]", -- this can only be used in the git_status source
		renamed = "[R]", -- this can only be used in the git_status source
		-- Status type
		untracked = "[?]",
		ignored = "[I]",
		unstaged = "[U]",
		staged = "[S]",
		conflict = "[X]",
	},
}
return M
