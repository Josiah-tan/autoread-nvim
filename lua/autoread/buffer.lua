local algo = RELOAD("autoread.algo")
M = {}

local getNames = function ()
	local paths = vim.api.nvim_exec(
	[[
	for buf in getbufinfo({"bufloaded":1})
		echo buf.bufnr.",".buf.name
	endfor
	]], 1)
	paths = algo.splitStr2(paths, '\n', ',')
	-- P("paths : ", paths )
	-- local paths = vim.api.nvim_exec([[
	-- for buf in getbufinfo({"bufloaded":1})
	-- 	echo buf.name
	-- endfor
	-- 	]], 1)
	-- paths = algo.splitStr(paths, '\n')
	return paths
end

M.fromFile = function (file_name)
	-- vim.api.nvim_buf_get_name(0) == file_name 
	-- getNames()[file_name]
	return getNames()[file_name]
end


return M
