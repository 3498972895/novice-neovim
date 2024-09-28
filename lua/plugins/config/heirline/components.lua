local common_utils = require("common.utils")
local heirline_utils = require("plugins.config.heirline.utils")
local C = {}

local BASE = {
	static = {
		container_width = 0,
		justify = "center", -- left, center, right
	},
}
local COMPONENTS = {

	VI_MODE = {
		provider = function(self)
			return heirline_utils.justify(self)
		end,
		update = "ModeChanged",
		condition = function(self)
			return not common_utils.is_non_filetype()
		end,
		init = function(self)
			self.content = string.format("%10s", self.vi_mode_map[vim.fn.mode()])
		end,
		static = common_utils.merge_table(BASE.static, {
			vi_mode_map = {
				i = "INSERT",
				v = "VISUAL",
				c = "COMMAND",
				n = "NORMAL",
			},
		}),
	},

	FILE_NAMING = {
		provider = function(self)
			local file = self.filename
			return " " .. string.format("%-40s", file)
		end,
		init = function(self)
			self.filename = common_utils.path_to_file_name(vim.api.nvim_buf_get_name(0))
		end,
	},
	FILE_ICON = {
		provider = function(self)
			return " " .. string.format("%-4s", self.file_icon)
		end,
		init = function(self)
			local filename = utils.path_to_file_name(vim.api.nvim_buf_get_name(0))
			local extension = vim.fn.fnamemodify(filename, ":e")
			self.file_icon = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
		end,
	},

	FILE_WRITEABLE = {
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = string.format("%4s", ""),
		hl = { fg = "orange" },
	},

	FILE_TYPE = {
		update = {
			"BufEnter",
			callback = function()
				return not common_utils.is_non_filetype()
			end,
		},
		provider = function()
			return string.upper(vim.bo.filetype)
		end,
	},
	FILE_ENCODE = {
		provider = function()
			local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
			return " " .. enc:upper()
		end,
	},
	FILE_SIZE = {
		provider = function()
			-- stackoverflow, compute human readable file size
			local suffix = { "b", "k", "M", "G", "T", "P", "E" }
			local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
			fsize = (fsize < 0 and 0) or fsize
			if fsize < 1024 then
				return " " .. fsize .. suffix[1]
			end
			local i = math.floor((math.log(fsize) / math.log(1024)))
			return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
		end,
	},
	FILE_MODIFIED = {
		-- file modified time comparing the current time
		-- if file modified time is today, show only time
		-- file modified time is not today, show only date
		provider = function()
			local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
			local last_modified = os.date("*t", ftime)
			local current_time = os.date("*t")
			local is_today = last_modified.year == current_time.year
				and last_modified.month == current_time.month
				and last_modified.day == current_time.day
			if is_today then
				local time = string.format("%02d:%02d:%02d", last_modified.hour, last_modified.min, last_modified.sec)
				return " " .. string.format("%-15s", time)
			else
				local time = string.format("%04d-%02d-%02d", last_modified.year, last_modified.month, last_modified.day)
				return " " .. string.format("%-15s", time)
			end
		end,
	},
	CURRENT_LINE = {
		-- %l = current line number
		provider = function(self)
			return string.format("%4s", self.current_line) .. ","
		end,
		init = function(self)
			self.current_line = "%l"
		end,
		update = "CursorMoved",
	},
	TOTAL_LINE = {
		-- %L = number of lines in the buffer
		provider = function(self)
			return string.format("%4s", self.total_line)
		end,
		init = function(self)
			self.total_line = "%L"
		end,
		update = {
			"BufEnter",
			callback = function()
				return not common_utils.is_non_filetype()
			end,
		},
	},

	COLUMN_LINE = {
		-- %c = column number
		provider = function(self)
			return string.format("%2s", self.column_number)
		end,
		init = function(self)
			self.column_number = "%c"
		end,
		update = "CursorMoved",
	},
	PERCENTAGE_LINE = {
		-- %P = percentage through file of displayed window
		provider = function(self)
			return string.format("%4s", self.percentage)
		end,
		init = function(self)
			self.percentage = "%p"
		end,
		update = "CursorMoved",
	},

	PERCENTAGE_MOVE = {
		provider = function(self)
			local x_10 = math.floor(tonumber(vim.fn.line(".")) / tonumber(vim.fn.line("$")) * 10)

			if x_10 < 1 then
				x_10 = 1
			elseif x_10 > 8 then
				x_10 = 8
			end
			return string.format("%4s", self.icons[x_10])
		end,
		static = {

			icons = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
		},
	},
}
-- @param properties.component_name:string  M.components
-- @param properties.container_width_percent:int 0 < x <1
C.create_component = function(component_name)
	local component = common_utils.copy_table_from(COMPONENTS[component_name])
	return component
end
return C
