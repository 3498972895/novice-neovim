local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	return
end

local U = require("heirline.utils")
local utils = require("common.utils")
-- content, margin, rep_mounts, rep_char
U.justify = function(properties)
	local content = properties.content
	local margin = properties.margin
	local rep_mounts = properties.rep_mounts
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
U.set_static = function(component, properties)
	if component.static == nil then
		component.static = {}
	end
	for key, value in pairs(properties) do
		component.static[key] = value
	end
end

return U
