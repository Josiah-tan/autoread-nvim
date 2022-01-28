M = {}

local _sets = {}

M.set = function (key, val)
	_sets[key] = val
end

M.log = function (val)
	if _sets["verbose"] then
		print(val)
	end
end

return M
