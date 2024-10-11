return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	opts = function()
		require("telescope").load_extension("fzf")
		local actions = require("telescope.actions")
		return {
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-n>"] = false,
						["<Down>"] = false,
						["<Up>"] = false,
					},
				},
			},
			pickers = {
				find_files = {
					theme = "dropdown",
				},
				fd = {
					theme = "dropdown",
				},
				grep_string = {
					theme = "dropdown",
				},
				live_grep = {
					theme = "dropdown",
				},
				buffers = {
					theme = "dropdown",
				},
				help_tags = {},
				lsp_references = {
					theme = "dropdown",
				},
				lsp_document_symbols = {
					theme = "dropdown",
				},
			},
			extensions = {},
		}
	end,
	keys = {
		{ "<leader>ff", ":Telescope fd<CR>", desc = "Telescope FIND FILES" },
		{ "<leader>fg", ":Telescope live_grep<CR>", desc = "Telescope LIVE GREP" },
		{ "<leader>fb", ":Telescope buffers<CR>", desc = "Telescope BUFFERS" },
		{ "<leader>fh", ":Telescope help_tags<CR>", desc = "Telescope HELP TAGS" },
		{ "<leader>fw", ":Telescope grep_string<CR>", desc = "Telescope FIND WORDS" },
		-- { "<leader>ff", ":Telescope find_files<CR>", desc = "Telescope find file" },
	},
}
