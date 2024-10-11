return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			autochdir = true,
			open_mapping = [[<f7>]],
			direction = "float",
			float_opts = {
				width = 100,
				height = 25,
				border = "curved",
				title_pos = "left",
			},
		})
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
		local bottom = Terminal:new({ cmd = "btm", hidden = true })

		function _lazygit_toggle()
			lazygit:toggle()
		end
		function _bottom_toggle()
			bottom:toggle()
		end
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tl",
			"<cmd>lua _lazygit_toggle()<CR>",
			{ noremap = true, silent = true, desc = "[T]ERMINAL [L]AZY GIT" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tb",
			"<cmd>lua _bottom_toggle()<CR>",
			{ noremap = true, silent = true, desc = "[T]ERMINAL [B]OTTOM" }
		)
	end,
}
