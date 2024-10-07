return {
	"rebelot/heirline.nvim",
	-- You can optionally lazy-load heirline on UiEnter
	-- to make sure all required plugins and colorschemes are loaded before setup
	event = "UiEnter",
	config = function()
		local create = require("plugins.config.heirline.components").create
		local utils = require("plugins.config.heirline.components").heirline_utils

		local colors = require("common.colors")

		local GIT_BRANCH = create("GIT_BRANCH")
		utils.set_static(GIT_BRANCH, { rep_mounts = 2 })

		local VI_MODE = create("VI_MODE")
		utils.set_static(VI_MODE, { rep_mounts = 0 })

		local FILE_TYPE = create("FILE_TYPE")
		utils.set_static(FILE_TYPE, { rep_mounts = 3 })

		local FILE_ICON = create("FILE_ICON")
		utils.set_static(FILE_ICON, { rep_mounts = 1 })

		local ALIGN = create("ALIGN")

		local FILE_SIZE = create("FILE_SIZE")
		utils.set_static(FILE_SIZE, { rep_mounts = 2 })

		local DIAGNOSTICS_ERROR = create("DIAGNOSTICS_ERROR")
		utils.set_static(DIAGNOSTICS_ERROR, { rep_mounts = 1 })

		local DIAGNOSTICS_WARN = create("DIAGNOSTICS_WARN")
		utils.set_static(DIAGNOSTICS_WARN, { rep_mounts = 1 })

		local DIAGNOSTICS_INFO = create("DIAGNOSTICS_INFO")
		utils.set_static(DIAGNOSTICS_INFO, { rep_mounts = 1 })

		local DIAGNOSTICS_HINT = create("DIAGNOSTICS_HINT")
		utils.set_static(DIAGNOSTICS_HINT, { rep_mounts = 1 })

		local GIT_INFO = create("GIT_INFO")
		utils.set_static(GIT_INFO, { rep_mounts = 2, margin = "right" })

		local LSP_ACTIVE = create("LSP_ACTIVE")
		utils.set_static(LSP_ACTIVE, { rep_mounts = 2, margin = "right" })

		local FILE_ENCODING = create("FILE_ENCODING")
		utils.set_static(FILE_ENCODING, { rep_mounts = 2, margin = "right" })

		local RULER = create("RULER")
		utils.set_static(RULER, { rep_mounts = 0 })

		require("heirline").setup({
			statusline = {
				hl = { bg = colors.status_line },
				{
					GIT_BRANCH,
					VI_MODE,
					FILE_TYPE,
					FILE_ICON,
					FILE_SIZE,
					DIAGNOSTICS_ERROR,
					DIAGNOSTICS_WARN,
					DIAGNOSTICS_INFO,
					DIAGNOSTICS_HINT,
					ALIGN,
					GIT_INFO,
					LSP_ACTIVE,
					FILE_ENCODING,
					RULER,
				},
			},
		})
	end,
}
