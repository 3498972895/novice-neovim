local keys = {}
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
	},
	opts = function()
		local mini_icons = require("mini.icons")
		return {
			preset = "helix",
			spec = {
				{ "<leader>b", group = "[B]UFFER" },
				{ "<leader>f", group = "TELESCOPE [F]IND" },
				{ "<leader>l", group = "[L]SP KEYS" },
				{ "[d", desc = "PREV DIAGNOTIC" },
				{ "]d", desc = "NEXT DIAGNOTIC" },
				{ "[%", hidden = true },
				{ "]%", hidden = true },
				{ "g", hidden = true },
				{ '"', desc = "SEE REGISTER RECORDING" },
				{ "'", desc = "SEE MARK RECORDING" },
				{ "`", desc = "MARKING" },
				{ "]", desc = "NEXT ACTION" },
				{ "[", desc = "PREV ACTION" },
				{ "<C-w>", hidden = true },
				{ "Y", hidden = true },
				{ "?", hidden = true },
				{ "<C-j>", hidden = true },
				{ "<C-k>", hidden = true },
				{ "<C-u>", hidden = true },
				{ "<C-d>", hidden = true },
				{ "<C-l>", hidden = true },
				{ "<C-l>", hidden = true },
				{ "<C-n>", hidden = true },
				{ "<C-p>", hidden = true },
				{ "%", hidden = true },
				{ "<esc>", hidden = true },

				{ "\\", hidden = true },
				{ "|", hidden = true },

				{ ">", desc = "INDENT TO RIGHT" },
				{ "<", desc = "INDENT TO LEFT" },

				{ "n", hidden = true },
				{ ">", hidden = true },
				{ "<", hidden = true },
				{ "f", hidden = true },
				{ "s", hidden = true },
				{ "q", hidden = true },

				{ "<C-Left>", hidden = true },
				{ "<C-Right>", hidden = true },
				{ "<C-Up>", hidden = true },
				{ "<C-Down>", hidden = true },

				{ "<leader>", desc = "LEADER MAPPING" },
				{ "<C-space>", desc = "CMP TRIGGER" },
				{ "<C-e>", desc = "CMP ABOART" },
				{ "K", desc = "LSP HOVER" },
				{ "<leader>t", desc = "TERMINAL" },
				{ "<F7>", desc = "TERMINAL [F7]+1/2/3" },
			},
			icons = {
				mappings = false,
			},
			plugins = {
				spelling = {
					enabled = false,
				},
				presets = {
					operators = false,
					motions = false,
					windows = false,
					text_objects = false,
					windows = false,
					nav = false,
					z = false,
					g = false,
				},
			},
			triggers = {
				{ "<leader>", mode = { "n" } },
				{ "[", mode = { "n" } },
				{ "]", mode = { "n" } },
				{ "g", mode = { "n" } },
			},
		}
	end,
	keys = {},
}
