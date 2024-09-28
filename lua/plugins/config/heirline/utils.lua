local common_utils = require("common.utils")
local U = {}
U.set_component_width = function(percent)
	return common_utils.get_win_width() * percent
end

-- justify needs to be called inside of component
-- @param properties.component:table M.components
-- @param properties.container_width:int 0 < x <1
U.justify = function(component)
	local content_width = #component.content
	local container_width = component.container_width
	if component.justify == "center" then
		local margin_width = (math.floor((container_width - content_width) / 2) < 0 and 1)
			or math.floor((container_width - content_width) / 2)
		return string.rep(" ", margin_width) .. component.content .. string.rep(" ", margin_width)
	end
	if component.justify == "left" then
		local margin_width = (math.floor(container_width - content_width) <= 0 and 1)
			or math.floor(container_width - content_width)
		return component.content .. string.rep(" ", margin_width)
	end
	if component.justify == "right" then
		local margin_width = (math.floor(container_width - content_width) <= 0 and 1)
		return string.rep(" ", margin_width) .. component.content
	end
end

--- Sets the component with the given parameters.
-- @param component:table The component
-- @param params: table should  contain the fields: container_width_percentage,justify
U.set = function(component, params)
	component.static.container_width = U.set_component_width(params.container_width_percentage)
	component.static.justify = params.justify
end
return U
