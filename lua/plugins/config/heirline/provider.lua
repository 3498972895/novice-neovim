local heirline_utils = require("plugins.config.heirline.utils")
local P = {}
P.justify = function(self)
	return heirline_utils.justify({
		content = self.content,
		margin = self.margin,
		rep_mounts = self.rep_mounts,
		rep_char = self.rep_char,
	})
end
return P
