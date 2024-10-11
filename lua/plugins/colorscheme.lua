return {
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").setup({
				transparent = {
					float = true,
					bg = true,
				},
				cursorline = {
					theme = "light",
					blend = 0.5,
				},
			})

			require("nordic").load()
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
