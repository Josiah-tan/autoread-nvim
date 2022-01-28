M = {}

local debug = require("autoread.debug")
local fold = require("autoread.fold")

M.onStdout = function(error, data, self, bufnr)
	vim.schedule(function ()
		vim.cmd("checktime ", bufnr)
		local windows = vim.fn.win_findbuf(bufnr)
		for _, window in ipairs(windows) do
			vim.api.nvim_win_set_cursor(window, {vim.fn.line('$', window), 0})
		end
		-- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, {data})
		-- print(error:result())
	end)
end

M.onStart = function (bufnr, file_name)
	debug.log('starting job for '..bufnr..', '..file_name)
	fold.setMethod(bufnr, "indent") -- remove those pesky folds!
end

M.onExit = function (self, code, signal, bufnr, file_name)
	debug.log('exiting job for '..bufnr..', '..file_name)
	fold.restoreMethod(bufnr)
end

return M

