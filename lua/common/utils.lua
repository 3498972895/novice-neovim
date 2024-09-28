local U = {}

U.path_to_file_name = function(path)
	local pattern = "([^/]+)$"
	local filename = string.match(path, pattern)
	return filename
end
U.is_non_filetype = function()
	if vim.bo.filetype == "neo-tree" or vim.bo.filetype == "alpha" then
		return true
	else
		return false
	end
end

U.get_win_width = function()
	return vim.api.nvim_win_get_width(0)
end

U.copy_table_from = function(original)
	local copy = {}
	for key, value in pairs(original) do
		copy[key] = value
	end
	return copy
end

U.merge_table = function(t1, t2, strategy)
	local result = {}
	strategy = strategy or "table" -- default save table option "value"

	for k, v in pairs(t1) do
		result[k] = v
	end

	for k, v in pairs(t2) do
		if result[k] ~= nil then
			if type(result[k]) == "table" and type(v) == "table" then
				result[k] = table_merge(result[k], v, strategy)
			else
				if strategy == "table" then
					if type(result[k]) == "table" then
						result[k] = table_merge(result[k], { v }, strategy)
					else
						result[k] = v
					end
				elseif strategy == "value" then
					result[k] = v
				else
					if type(result[k]) == "table" then
						result[k] = table_merge(result[k], { v }, strategy)
					else
						result[k] = v
					end
				end
			end
		else
			result[k] = v
		end
	end

	return result
end
return U
