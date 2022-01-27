M = {}
local _opts = require("autoread.state").opts.builtin
local state = require("autoread.state")
local path = require("autoread.path")
local job = require("autoread.job")


M.autoReadStart = function(opts)
	opts = vim.tbl_deep_extend("force", _opts, opts or {})
	local file_name = path.getFileName(opts)
	local started = "started"..file_name
	if not state.get(started) then
		local status = job.start(file_name, opts.job)
		state.set(started, not status)
	else
		print(string.format(
		"Job already started for %s, run require('autoread.builtin').autoReadStop() first",
		file_name
		))
		return
	end
end

M.autoReadStop = function(opts)
	opts = vim.tbl_deep_extend("force", _opts, opts or {})
	local file_name = path.getFileName(opts)
	local started = "started"..file_name
	if state.get(started) then
		local status = job.stop(file_name, opts.job)
		state.set(started, status)
	else
		print(string.format(
		"Job not started yet for %s, run require('autoread.builtin').autoReadStart() first",
		file_name
		))
		return
	end
end

return M
