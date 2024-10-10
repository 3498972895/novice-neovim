return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		"saadparwaiz1/cmp_luasnip",
	},
	opts = function()
		-- lsp cmp
		local cmp = require("cmp")
		local sources = {
			{ name = "nvim_lsp", priority = 1000 },
			{ name = "luasnip", priority = 500 },
			{ name = "path", priority = 250 },
		}

		-- useful snip
		local ls = require("luasnip")
		ls.snippets = ls.snippets or {}
		local snippets = require("common.snippets")

		for _, snippet in ipairs(snippets) do
			for _, ft in ipairs(snippet.filetype) do
				ls.add_snippets(ft, { ls.parser.parse_snippet(snippet.keyword, snippet.content) })
			end
		end
		return {
			enable = true,
			completion = {
				autocomplete = false,
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					col_offset = -2,
					side_padding = 0,
					-- border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					-- border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				}),
			},
			view = {
				docs = {
					auto_open = false,
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
				["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "c" }),
				["<C-l>"] = cmp.mapping(cmp.mapping.open_docs(), { "i", "c" }),
				["<C-h>"] = cmp.mapping(cmp.mapping.close_docs(), { "i", "c" }),
			}),
			sources = cmp.config.sources(sources),
		}
	end,
}
