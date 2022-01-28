M = {}

local state = require("autoread.state")

M.setMethod = function (bufnr, foldmethod)
	local windows = vim.fn.win_findbuf(bufnr)
	for _, window in ipairs(windows) do
		state.set("foldmethod"..window, vim.api.nvim_win_get_option(window, "foldmethod"))
		vim.api.nvim_win_set_option(window, "foldmethod", foldmethod)
	end
end

M.restoreMethod = function (bufnr)
	local windows = vim.fn.win_findbuf(bufnr)
	for _, window in ipairs(windows) do
		local foldmethod = state.get("foldmethod"..window)
		vim.api.nvim_win_set_option(window, "foldmethod", foldmethod)
	end
end

return M
