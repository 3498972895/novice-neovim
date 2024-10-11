local colors = {
	-- navic_bg = "#011627",
	-- navic_fg = "#ffffff",
	navic_bg = "#242933",
}
local icons = {
	File = "󰈙 ",
	Module = " ",
	Namespace = "󰌗 ",
	Package = " ",
	Class = "󰌗 ",
	Method = "󰆧 ",
	Property = " ",
	Field = " ",
	Constructor = " ",
	Enum = "󰕘",
	Interface = "󰕘",
	Function = "󰊕 ",
	Variable = "󰆧 ",
	Constant = "󰏿 ",
	String = "󰀬 ",
	Number = "󰎠 ",
	Boolean = "◩ ",
	Array = "󰅪 ",
	Object = "󰅩 ",
	Key = "󰌋 ",
	Null = "󰟢 ",
	EnumMember = " ",
	Struct = "󰌗 ",
	Event = " ",
	Operator = "󰆕 ",
	TypeParameter = "󰊄 ",
}

return {
	"SmiteshP/nvim-navic",
	opts = function()
		local highlights = {
			"NavicIconsFile",
			"NavicIconsModule",
			"NavicIconsNamespace",
			"NavicIconsPackage",
			"NavicIconsClass",
			"NavicIconsMethod",
			"NavicIconsProperty",
			"NavicIconsField",
			"NavicIconsConstructor",
			"NavicIconsEnum",
			"NavicIconsInterface",
			"NavicIconsFunction",
			"NavicIconsVariable",
			"NavicIconsConstant",
			"NavicIconsString",
			"NavicIconsNumber",
			"NavicIconsBoolean",
			"NavicIconsArray",
			"NavicIconsObject",
			"NavicIconsKey",
			"NavicIconsNull",
			"NavicIconsEnumMember",
			"NavicIconsStruct",
			"NavicIconsEvent",
			"NavicIconsOperator",
			"NavicIconsTypeParameter",
			"NavicText",
			"NavicSeparator",
		}

		for _, hl in ipairs(highlights) do
			vim.api.nvim_set_hl(0, hl, { default = true, bg = colors.navic_bg, fg = colors.navic_fg })
		end

		require("nvim-navic").setup({
			icons = icons,
			lsp = {
				auto_attach = true,
				preference = nil,
			},
			highlight = false,
			separator = " > ",
			depth_limit = 0,
			depth_limit_indicator = "..",
			safe_output = true,
			lazy_update_context = false,
			click = false,
		})
	end,
}
