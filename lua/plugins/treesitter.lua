return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufAdd",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline", -- Must be installed
			"html",
			"javascript",
			"typescript",
			"scss",
			"css",
			"json",
			"tsx",
			"python",
		},
		auto_install = false,
		highlight = {
			enable = true,
		},
	},
}
