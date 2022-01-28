M = {}

local default = require("autoread.default")
local state = require("autoread.state")
-- local global = require("autoread.global")

M.setup = function (opts)
	opts = vim.tbl_deep_extend("force", default.opts, opts or {})
	state.update(opts)
	-- P("state", state)
	if not M.opts.disable_default_mappings then
		defaults.mappings()
	end
	-- global.set("verbose", opts.verbose)
end


return M
