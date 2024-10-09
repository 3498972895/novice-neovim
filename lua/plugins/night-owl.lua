return {
	"oxfist/night-owl.nvim",
	name = "night-owl",
	lazy = false,
	priority = 1000,
	config = function()
		require("night-owl").setup()
		vim.cmd.colorscheme("night-owl")
	end,
}
