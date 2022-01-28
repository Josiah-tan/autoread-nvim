M = {}

local default = require("autoread.default")
local debug = require("autoread.debug")
-- note that this must be required last otherwise weird things happen!
local state = require("autoread.state")

M.setup = function (opts)
	opts = vim.tbl_deep_extend("force", default.opts, opts or {})
	state.update(opts)
	-- P("state", state)
	if not M.opts.disable_default_mappings then
		defaults.mappings()
	end
	debug.set("verbose", opts.verbose)
end


return M
