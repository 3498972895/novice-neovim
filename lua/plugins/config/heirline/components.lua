local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	return
end

local heirline_conditions = require("plugins.config.heirline.conditions")
local heirline_utils = require("plugins.config.heirline.utils")
local heirline_provider = require("plugins.config.heirline.provider")
local icons = require("common.icons")
local utils = require("common.utils")
local colors = require("common.colors")
local C = {}

-- content, margin, rep_mounts, rep_char

C.VI_MODE = {
	provider = heirline_provider.justify,
	init = function(self)
		self.content = string.format("%10s", self.vi_mode[vim.fn.mode()])
	end,
	static = {
		vi_mode = {
			i = "INSERT",
			n = "NORMAL",
			v = "VISUAL",
			c = "COMMAND",
		},
	},
	update = "ModeChanged",
	condition = heirline_conditions.is_file,
}

C.FILE_ICON = {
	provider = heirline_provider.justify,
	init = function(self)
		local filename = vim.api.nvim_buf_get_name(0)
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.content = require("nvim-web-devicons").get_icon(filename, extension, { default = true })
	end,
	update = {

		"BufEnter",
		callback = heirline_conditions.is_file,
	},
	condition = heirline_conditions.is_file,
}

C.FILE_TYPE = {
	provider = heirline_provider.justify,
	init = function(self)
		self.content = vim.bo.filetype
	end,
	update = {
		"BufEnter",
		callback = heirline_conditions.is_file,
	},
	condition = heirline_conditions.is_file,
}

C.ALIGN = {

	provider = "%=",
}
C.FILE_SIZE = {
	provider = heirline_provider.justify,
	init = function(self)
		local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
		fsize = (fsize < 0 and 0) or fsize
		if fsize < 1024 then
			self.content = fsize .. self.suffix[1]
			return
		end
		local i = math.floor((math.log(fsize) / math.log(1024)))
		self.content = string.format("%.2g%s", fsize / math.pow(1024, i), self.suffix[i + 1])
	end,
	static = {
		suffix = { "b", "k", "M", "G", "T", "P", "E" },
	},
	update = {
		"BufEnter",
		callback = heirline_conditions.is_file,
	},
	condition = heirline_conditions.is_file,
}
C.FILE_ENCODING = {
	provider = heirline_provider.justify,
	init = function(self)
		local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
		self.content = enc
	end,
	update = {
		"BufEnter",
		callback = heirline_conditions.is_file,
	},
	condition = heirline_conditions.is_file,
}
C.RULER = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = heirline_provider.justify,
	init = function(self)
		self.content = "%3l:%-2c %P"
	end,
	update = "CursorMoved",
	condition = heirline_conditions.is_file,
}
C.LSP_ACTIVE = {
	condition = heirline_conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },
	provider = heirline_provider.justify,
	init = function(self)
		local names = {}
		for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		self.content = " [" .. table.concat(names, " ") .. "]"
	end,
}

C.DIAGNOSTICS_ERROR = {
	provider = heirline_provider.justify,
	init = function(self)
		local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		if errors > 0 then
			self.content = self.error_icon .. errors
		else
			self.content = ""
		end
	end,
	condition = heirline_conditions.has_diagnostics,
	static = {
		-- error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
		error_icon = icons.diagnostic_sign.error,
	},
	update = { "DiagnosticChanged", "BufEnter" },

	hl = { fg = colors.error },
}
C.DIAGNOSTICS_WARN = {
	provider = heirline_provider.justify,
	init = function(self)
		local warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		if warn > 0 then
			self.content = self.warn_icon .. warn
		else
			self.content = ""
		end
	end,
	condition = heirline_conditions.has_diagnostics,
	static = {
		-- warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
		warn_icon = icons.diagnostic_sign.warn,
	},
	update = { "DiagnosticChanged", "BufEnter" },

	hl = { fg = colors.warn },
}
C.DIAGNOSTICS_INFO = {
	provider = heirline_provider.justify,
	init = function(self)
		local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		if info > 0 then
			self.content = self.info_icon .. info
		else
			self.content = ""
		end
	end,
	condition = heirline_conditions.has_diagnostics,
	static = {
		-- info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,

		info_icon = icons.diagnostic_sign.info,
	},
	update = { "DiagnosticChanged", "BufEnter" },

	hl = { fg = colors.info },
}
C.DIAGNOSTICS_HINT = {
	provider = heirline_provider.justify,
	init = function(self)
		local hint = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		if hint > 0 then
			self.content = self.hint_icon .. hint
		else
			self.content = ""
		end
	end,
	condition = heirline_conditions.has_diagnostics,
	static = {
		-- hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
		hint_icon = icons.diagnostic_sign.hint,
	},
	update = { "DiagnosticChanged", "BufEnter" },
	hl = { fg = colors.hint },
}
C.GIT_BRANCH = {
	provider = heirline_provider.justify,
	hl = { bold = true },
	condition = function()
		return vim.g.gitsigns_head and vim.bo.filetype == "neo-tree"
	end,
	update = { "User", pattern = "GitsignsRefresh" },
	init = function(self)
		if vim.g.gitsigns_head then
			self.content = " " .. vim.g.gitsigns_head
		else
			self.content = ""
		end
	end,
}
C.GIT_INFO = {

	provider = heirline_provider.justify,
	condition = heirline_conditions.is_git_repo,
	update = { "BufEnter", "BufWritePost", "BufReadPost" },
	init = function(self)
		local status_dict = vim.b.gitsigns_status_dict
		local diff_added = status_dict.added or 0
		local diff_removed = status_dict.removed or 0
		local diff_changed = status_dict.changed or 0
		if diff_added ~= 0 or diff_removed ~= 0 and diff_changed ~= 0 then
			self.content = "["
				.. icons.git_symbols.icon.diff_added
				.. diff_added
				.. icons.git_symbols.icon.diff_removed
				.. diff_removed
				.. icons.git_symbols.icon.diff_changed
				.. diff_changed
				.. "]"
		else
			self.content = ""
		end
	end,
}
function create(component_name)
	local component = utils.copy_table_from(C[component_name])
	if component.static == nil then
		component.static = {}
	end
	component.static = utils.merge_table(component.static, {
		margin = "left",
		rep_mounts = 1,
		rep_char = " ",
	})
	return component
end

return { create = create, heirline_conditions = heirline_conditions, heirline_utils = heirline_utils }
