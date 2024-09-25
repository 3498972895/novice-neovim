return {
	"tiagovla/scope.nvim",
	opts = {
		hooks = {},
	},
	keys = {
		{ "]t", ":tabnext<CR>", desc = "NEXT TAB" },
		{ "[t", ":tabprevious<CR>", desc = "PREV TAB" },
		{ "<leader>tc", ":tabclose<CR>", desc = "[C]LOSE TAB" },
		{ "<leader>tn", ":tabnew<CR>", desc = "[N]EW TAB" },
	},
}
