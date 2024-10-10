function is_file()
	if vim.bo.filetype == "neo-tree" or vim.bo.filetype == "alpha" or vim.bo.filetype == "nvim-tree" then
		return false
	end
	return true
end

function justify(properties)
	local content = properties.content
	local margin = properties.margin or "left"
	local rep_mounts = properties.rep_mounts or 2
	local rep_char = properties.rep_char or " "
	if margin == "left" then
		return string.rep(rep_char, rep_mounts) .. content
	end
	if margin == "right" then
		return content .. string.rep(rep_char, rep_mounts)
	end

	if margin == "center" then
		return string.rep(rep_char, rep_mounts) .. content .. string.rep(rep_char, rep_mounts)
	end
end

local colors = {
	statusline_bg = "#0A2A3F",
	winbar_bg = "#011627",
	git_branch_fg = "orange",
	error = vim.api.nvim_get_hl_by_name("DiagnosticSignError", true).foreground,
	warn = vim.api.nvim_get_hl_by_name("DiagnosticSignWarn", true).foreground,
	info = vim.api.nvim_get_hl_by_name("DiagnosticSignInfo", true).foreground,
	hint = vim.api.nvim_get_hl_by_name("DiagnosticSignHint", true).foreground,
	buf_active = "red",
	buf_inactive = "#666666",
	buf_trunc = "gray",
	sidebar_active_fg = "#888888",
	sidebar_inactive_fg = "#333333",
}
local icons = {
	diff_added = "+",
	diff_removed = "-",
	diff_changed = "~",
	buf_tag_head = "⏽",
	buf_left_trunc = "",
	buf_right_trunc = "",
}

return {
	"rebelot/heirline.nvim",
	-- You can optionally lazy-load heirline on UiEnter
	-- to make sure all required plugins and colorschemes are loaded before setup

	event = "UiEnter",
	config = function()
		local heirline = require("heirline")
		local heirline_conditions = require("heirline.conditions")
		local heirline_utils = require("heirline.utils")
		-- status line components
		local statusline = {

			hl = { bg = colors.statusline_bg },
			{
				provider = justify,
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
			},
			{
				provider = justify,
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
				condition = is_file,
			},
			{
				update = {
					"BufEnter",
					pattern = "*.*",
				},
				condition = is_file,
				{
					{
						provider = justify,
						init = function(self)
							self.content = vim.bo.filetype
						end,
					},
					{
						provider = justify,
						init = function(self)
							local filename = vim.api.nvim_buf_get_name(0)
							local extension = vim.fn.fnamemodify(filename, ":e")
							self.content =
								require("nvim-web-devicons").get_icon(filename, extension, { default = true })
						end,
					},
					{
						provider = justify,
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
					},
				},
			},
			{

				update = { "DiagnosticChanged", "BufEnter" },
				condition = heirline_conditions.has_diagnostics,
				{
					provider = justify,
					init = function(self)
						local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
						if errors > 0 then
							self.content = self.error_icon .. errors
						else
							self.content = ""
						end
					end,
					static = {
						error_icon = " ",
					},

					hl = { fg = colors.error },
				},
				{
					provider = justify,
					init = function(self)
						local warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
						if warn > 0 then
							self.content = self.warn_icon .. warn
						else
							self.content = ""
						end
					end,
					static = {
						warn_icon = " ",
					},

					hl = { fg = colors.warn },
				},
				{
					provider = justify,
					init = function(self)
						local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
						if info > 0 then
							self.content = self.info_icon .. info
						else
							self.content = ""
						end
					end,
					static = {
						info_icon = " ",
					},
					hl = { fg = colors.info },
				},
				{
					provider = justify,
					init = function(self)
						local hint = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
						if hint > 0 then
							self.content = self.hint_icon .. hint
						else
							self.content = ""
						end
					end,
					static = {
						hint_icon = "󰌵",
					},
					hl = { fg = colors.hint },
				},
			},
			{

				provider = "%=",
				update = function()
					return false
				end,
			},
			{

				provider = justify,
				condition = heirline_conditions.is_git_repo,
				init = function(self)
					local status_dict = vim.b.gitsigns_status_dict
					local diff_added = status_dict.added or 0
					local diff_removed = status_dict.removed or 0
					local diff_changed = status_dict.changed or 0
					if diff_added > 0 or diff_removed > 0 or diff_changed > 0 then
						self.content = "["
							.. icons.diff_added
							.. diff_added
							.. icons.diff_removed
							.. diff_removed
							.. icons.diff_changed
							.. diff_changed
							.. "]"
					else
						self.content = ""
					end
				end,
			},
			{
				provider = justify,
				condition = heirline_conditions.lsp_attached,
				update = { "LspAttach", "LspDetach" },
				init = function(self)
					local names = {}
					for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
						table.insert(names, server.name)
					end
					self.content = " [" .. table.concat(names, " ") .. "]"
				end,
			},
			{

				condition = is_file,
				{
					provider = justify,
					init = function(self)
						local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
						self.content = enc
					end,
					update = { "BufEnter", pattern = "*.*" },
				},

				{
					-- %l = current line number
					-- %L = number of lines in the buffer
					-- %c = column number
					-- %P = percentage through file of displayed window
					provider = justify,
					init = function(self)
						self.content = "%3l:%-2c %P"
					end,
					update = "CursorMoved",
				},
			},
		}
		local winbar = {
			hl = { bg = colors.winbar_bg },
			{
				provider = justify,
				condition = function()
					return require("nvim-navic").is_available()
				end,
				init = function(self)
					self.content = require("nvim-navic").get_location({ highlight = true })
				end,
				update = "CursorMoved",
			},
			{

				provider = "%=",
				update = function()
					return false
				end,
			},
			{
				provider = justify,
				init = function(self)
					self.content = vim.fn.expand("%:p:h")
				end,
				update = { "BufEnter", pattern = "*.*" },
				condition = is_file,
			},
		}

		local tabline_offset = {
			condition = function(self)
				local win = vim.api.nvim_tabpage_list_wins(0)[1]
				local bufnr = vim.api.nvim_win_get_buf(win)
				self.winid = win

				if vim.bo[bufnr].filetype == "neo-tree" or vim.bo[bufnr].filetype == "NvimTree" then
					self.title = "File Directory"
					return true
				end
			end,

			provider = function(self)
				local title = self.title
				local width = vim.api.nvim_win_get_width(self.winid)
				local pad = math.ceil((width - #title)) - 2
				return "  " .. title .. string.rep(" ", pad)
			end,

			hl = function(self)
				if vim.api.nvim_get_current_win() == self.winid then
					return { fg = colors.sidebar_active_fg }
				else
					return { fg = colors.sidebar_inactive_fg }
				end
			end,
		}
		local bufferline = heirline_utils.make_buflist({
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(self.bufnr)
			end,
			{
				provider = icons.buf_tag_head,

				hl = function(self)
					if self.is_active or self.is_visible then
						return { fg = colors.buf_active }
					else
						return {
							fg = colors.buf_inactive,
						}
					end
				end,
			},
			{
				provider = function(self)
					local filename = self.filename
					filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
					return " " .. filename .. " "
				end,
				hl = function(self)
					if self.is_active or self.is_visible then
						return {
							bold = true,
							italic = true,
						}
					else
						return {
							fg = colors.buf_inactive,
						}
					end
				end,
			},
		}, {
			provider = icons.buf_left_trunc,
			hl = { fg = colors.buf_trunc },
		}, { provider = icons.buf_right_trunc, hl = { fg = colors.buf_trunc } })

		local tabline = { tabline_offset, bufferline }
		heirline.setup({ statusline = statusline, winbar = winbar, tabline = tabline })
	end,
}
