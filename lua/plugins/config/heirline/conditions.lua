local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	return
end
local utils = require("common.utils")

local C = require("heirline.conditions")

C.is_file = function()
	if vim.bo.filetype == "neo-tree" or vim.bo.filetype == "alpha" or vim.bo.filetype == "nvim-tree" then
		return false
	end
	return true
end
return C
