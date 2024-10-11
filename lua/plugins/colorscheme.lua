return {
	{
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		name = "nord",
		config = function()
			vim.g.nord_borders = true
			vim.g.nord_contrast = true
			require("nord").set()
		end,
	},
	{
		"oxfist/night-owl.nvim",
		lazy = true,
		priority = 500,
		name = "night-owl",
		config = function()
			require("night-owl").setup()
			vim.cmd.colorscheme("night-owl")
		end,
	},
}
