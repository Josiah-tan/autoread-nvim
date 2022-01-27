M = {}

---on_start function       : Run when starting job
---on_stdout function      : (error: string, data: string, self? Job)
---on_exit function        : (self, code: number, signal: number)

M.onStdout = function(error, data, self, bufnr)
	-- local bufnr = 12
	vim.schedule(function ()
		vim.cmd("checktime ", bufnr)
		-- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, {return_val})
	end)
	-- print(j:result())
end

M.onExit = function (self, code, signal)
	print("exiting")
end

M.onStart = function () 
	print('starting')
end

return M
