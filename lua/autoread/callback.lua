M = {}

-- local global = require("autoread.global")

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

M.onExit = function (self, code, signal, bufnr)
	print("exiting")
	-- global.log("exiting")
end

M.onStart = function (bufnr)
	print('starting')
	-- global.log('starting')
end

return M

