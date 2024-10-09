return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = function()
		return {
			close_if_last_window = true,
			enable_diagnostics = false,
			window = {
				width = 30,
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						added = "[+]",
						modified = "[M]",
						deleted = "[-]",
						renamed = "[R]",
						untracked = "[?]",
						ignored = "[I]",
						unstaged = "[U]",
						staged = "[S]",
						conflict = "[X]",
					},
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		}
	end,
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "[E]XPLORE" },
	},
}
