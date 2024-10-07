local I = {}
I.git_symbols = {
	icon = {
		added = "[+]",
		modified = "[M]",
		deleted = "[-]",
		renamed = "[R]",
		untracked = "[?]",
		ignored = "[I]",
		unstaged = "[U]",
		staged = "[S]",
		conflict = "[X]",
		diff_added = "+",
		diff_removed = "-",
		diff_changed = "~",
	},
}

I.diagnostic_sign = {
	error = " ",
	warn = " ",
	info = " ",
	hint = "󰌵",
}

return I
