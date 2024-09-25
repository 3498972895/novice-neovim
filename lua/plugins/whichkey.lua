local keys = {}
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "echasnovski/mini.icons", config = {} },
	},
	opts = function()
		local mini_icons = require("mini.icons")
		return {
			preset = "helix",
			spec = {
				{ "<leader>b", group = "[B]UFFER" },
				{ "<leader>f", group = "TELESCOPE [F]IND" },
				{ "<leader>l", group = "[L]SP KEYS" },
				{ "<leader>t", group = "[T]AB WORKSPACE" },
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
				{ "<C-w>", desc = "DIAGNOTIC" },
				{ "<leader>", desc = "LEADER MAPPING" },
				{ "<C-j>", desc = "NEXT TELESCOPE / CMP /  FOCUS BLEW WINDOW" },
				{ "<C-k>", desc = "PREV SELECTION / CMP / FOCUS UP WINDOW" },

				{ "<C-n>", desc = "NEXT SELECTION" },
				{ "<C-k>", desc = "PREV SELECTION" },

				{ "<C-u>", desc = "UP CMP_DOC_SCROLL/WK/BUFFER" },
				{ "<C-d>", desc = "DOWN CMP_DOC_SCROLL/WK/BUFFER" },
				{ "<C-l>", desc = "CMP_DOC_OPEN / FOCUS RIGHT WINDOW" },
				{ "<C-h>", desc = "CMP_DOC_CLOSE/ FOCUS LEFT WINDOW" },

				{ "<C-space>", desc = "CMP TRIGGER" },
				{ "<C-e>", desc = "CMP ABOART" },

				{ "\\", desc = "SPLIT WINDOW BLEW" },
				{ "|", desc = "SPLIT WINDOW RIGHT" },

				{ ">", desc = "INDENT TO RIGHT" },
				{ "<", desc = "INDENT TO LEFT" },
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
			},
		}
	end,
	keys = {},
}
