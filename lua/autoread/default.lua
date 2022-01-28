M = {}

local getJob = function ()
	local job = nil
	if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
		job = {
			command = 'tail',
			args = {'-n0', '-F', '--', "%s"}
		}
	else
		job = {
			command = "sh",
			args = {'-c', 'tail -n0 -F -- %s'},
		}
	end
	-- P("job: ", job)
	return job
end

M.builtin = {
	job = getJob(),
	cwd = nil,
	file_name = nil
}


M.mappings = function ()
	vim.keymap.set("n", "<leader>js", function() require("autoread.builtin").autoReadStart() end)
	vim.keymap.set("n", "<leader>je", function() require("autoread.builtin").autoReadStop() end)
end

M.opts = {
	builtin = M.builtin,
	disable_default_mappings = true,
	verbose = false
}

return M
