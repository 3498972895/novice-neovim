return {
	"akinsho/bufferline.nvim",
	version = "*",
	lazy = false,
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					text_align = "center",
					separator = true,
				},
			},
		},
	},
	keys = {
		{ "<leader>bl", ":BufferLineCloseLeft<CR>", desc = "CLOSE [L]EFT BUFFER" },
		{ "<leader>br", ":BufferLineCloseRight<CR>", desc = "CLOSE [R]IGHT BUFFER" },
		{ "<leader>bo", ":BufferLineCloseOthers<CR>", desc = "CLOSE [O]THERS BUFFER" },
	},
}
