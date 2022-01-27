M = {}

local default = require("autoread.default")
local state = require("autoread.state")


M.setup = function (opts)
	opts = vim.tbl_deep_extend("force", default.opts, opts or {})
	state.update(opts)
	if not M.opts.disable_default_mappings then
		defaults.mappings()
	end
end


return M
