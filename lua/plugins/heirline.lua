local heirline_components = require("plugins.config.heirline.components")
local heirline_utils = require("plugins.config.heirline.utils")
local VI_MODE = heirline_components.create_component("VI_MODE")
heirline_utils.set(VI_MODE, { container_width_percentage = 0.25, justify = "center" })
local statusline = {
	VI_MODE,
}
return {
	"rebelot/heirline.nvim",
	-- You can optionally lazy-load heirline on UiEnter
	-- to make sure all required plugins and colorschemes are loaded before setup
	event = "UiEnter",
	opts = function()
		return {
			statusline = statusline,
			winbar = {},
			tabline = {},
			statuscolumn = {},
			opts = {},
			restrict = {
				common = true,
			},
		}
	end,
}
