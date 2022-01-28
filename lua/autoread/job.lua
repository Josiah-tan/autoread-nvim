M = {}
local debug = require("autoread.debug")
local state = require("autoread.state")
local buffer = RELOAD("autoread.buffer")
local callback = RELOAD("autoread.callback")
local Job = require("plenary.job")

local getArgs = function (args, file_name)
 for i, arg in ipairs(args) do
	 if string.find(arg, "%s", 1, 1) then
		 args[i] = string.format(arg, file_name)
	 end
 end
 return args
end

M.start = function (file_name, opts)
	local bufnr = buffer.fromFile(file_name)
	-- if buffer.FileExists(file_name) then
	if bufnr then
		local jobID = "jobID"..file_name
		local job = Job:new({
			command = opts.command,
			args = getArgs(opts.args, file_name),
			on_stdout = function(error, data, self)
				callback.onStdout(error, data, self, bufnr)
			end,
			on_start = function()
				callback.onStart(bufnr, file_name)
			end,
			on_exit = function (self, code, signal)
				callback.onExit(self, code, signal, bufnr, file_name)
			end,
		})
		job:start()
		state.set(jobID, job)
		return false
	else
		-- print(string.format("buf with file_name '%s' does not exist", file_name))
		debug.log(string.format("buf with file_name '%s' does not exist", file_name))
		return true
	end
end

M.stop = function (file_name, opts)
	local jobID = "jobID"..file_name
	local job = state.get(jobID)
	if job then
		job:shutdown()
		return false
	else
		-- print(string.format("Error: Job with file_name '%s' does not exist", file_name))
		debug.log(string.format("Error: Job with file_name '%s' does not exist", file_name))
		return true
	end
end

return M
