return {
	"stevearc/conform.nvim",
	event = { "BufReadPre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = false, lsp_format = "fallback" })
			end,
			mode = "n",
			desc = "LSP: LSP FORMAT BUFFER",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = function(bufnr)
			local disable_filetypes = {}
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 300,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			javascript = { "deno_fmt_js" },
			typescript = { "deno_fmt_js" },
			javascriptreact = { "deno_fmt" },
			typescripteact = { "deno_fmt" },
			json = { "deno_fmt" },
			jsonc = { "deno_fmt" },
			markdown = { "deno_fmt" },
			html = { "deno_fmt" },
			css = { "deno_fmt" },
			scss = { "deno_fmt" },
			sass = { "deno_fmt" },
			less = { "deno_fmt" },
			astro = { "deno_fmt" },
			svelte = { "deno_fmt" },
			vue = { "deno_fmt" },
			yaml = { "deno_fmt" },
		},
		formatters = {
			deno_fmt_js = {
				command = "deno",
				args = { "fmt", "$FILENAME", "--single-quote=true", "--prose-wrap=preserve", "--no-semicolons=true" },
				stdin = false,
			},
		},
	},
}
