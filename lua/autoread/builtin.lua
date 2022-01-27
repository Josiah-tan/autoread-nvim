M = {}
local job = nil
local Job = require('plenary.job')
local function getCommand(file)
	local cmd = string.format("tail -n0 -F -- %s", file)
	-- return string.format("sh -c '%s'", cmd)
	if vim.fn.has("win32") or vim.fn.has("win64") then
		return cmd
	else
		return string.format("sh -c '%s'", cmd)
	end
end

local handleStdOut = function(j, return_val)
	print("j", j)
	print("return_val", return_val)
	local bufnr = 12
	vim.schedule(function ()
		vim.cmd[[checktime]]
		-- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, {return_val})
	end)
	-- print(j:result())
end

M.autoReadStart = function(opts)
	local file_name = vim.fn.expand("%")
	file_name = vim.fn.fnamemodify(file_name, ':p')
	local buff = vim.api.nvim_get_current_buf()
	-- vim.cmd[[echo bufnr('%')]]
	-- local agroup = 'vim-autoread-'..buff
	-- P("agroup : ", agroup )
	-- local agroup_cmd = 'augroup '..agroup
	-- P("agroup_cmd : ", agroup_cmd )
	-- return
	local command = getCommand(file_name)
	P("command : ", command )
	job = Job:new({
		-- command = command,
		-- command = "tail",
		command = "sh",
		-- args = {'-f', '---disable-inotify', 'lua/autoread/builtin.lua'},
		args = {'-c', 'tail -n0 -F -- /home/josiah/.config/plover/clippy_2.org'},
		on_stdout = handleStdOut
	})
	job:start()
end

M.autoReadStop = function(opts)
	job:shutdown()
end

vim.keymap.set("n", "<leader>js", function() M.autoReadStart() end)
vim.keymap.set("n", "<leader>je", function() M.autoReadStop() end)
return M
