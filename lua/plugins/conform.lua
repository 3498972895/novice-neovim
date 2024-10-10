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
			javascript = { "deno_fmt" },
			typescript = { "deno_fmt" },
			javascriptreact = { "deno_fmt" },
			typescripteact = { "deno_fmt" },
			json = { "deno_fmt" },
			jsonc = { "deno_fmt" },
			markdown = { "deno_fmt" },
			html = { "deno_fmt" },
			css = { "deno_css" },
			scss = { "deno_css" },
			sass = { "deno_css" },
			less = { "deno_css" },
			astro = { "deno_component" },
			svelte = { "deno_component" },
			vue = { "deno_component" },
			yaml = { "deno_yaml" },
		},
		formatters = {
			deno_fmt = {
				command = "deno",
				args = { "fmt", "$FILENAME", "--single-quote=true", "--prose-wrap=preserve", "--no-semicolons=true" },
				stdin = false,
			},
			deno_css = {
				command = "deno",
				args = { "fmt", "--unstable-css", "$FILENAME" },
				stdin = false,
			},
			deno_html = {
				command = "deno",
				args = { "fmt", "--unstable-html", "$FILENAME" },
				stdin = false,
			},
			deno_yaml = {
				command = "deno",
				args = { "fmt", "--unstable-yaml", "$FILENAME" },
				stdin = false,
			},
			deno_component = {
				command = "deno",
				args = { "fmt", "--unstable-component", "$FILENAME" },
				stdin = false,
			},
		},
	},
}
