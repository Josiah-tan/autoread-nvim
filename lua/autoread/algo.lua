M = {}

local splitStr = function (inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		str = vim.fn.resolve(str)
		-- P("str : ", str )
		-- t[str] = true
		table.insert(t, str)
	end
	return t
end


local array2Dict = function (array, sep)
	local t = {}
	P(array)
	for _, s in ipairs(array) do
		local words = {}
		for word in string.gmatch(s, '([^,]+)') do
			table.insert(words, word)
		end
		if words[2] then
			t[words[2]] = tonumber(words[1])
		end
		-- array[i] = {}
		-- array[i][words[1]] = words[2]
	end
	return t
end

M.splitStr2 = function (inputstr, sep1, sep2)
	local array = splitStr(inputstr, sep1)
	local dict = array2Dict(array, sep2)
	P("dict : ", dict )
	return dict
	-- for i, s in ipairs(inputstr) do
	-- 	inputstr[i] = array2Dict(s, sep2)
	-- end
	-- return inputstr
end

-- M.splitStr2("12,hello\n13,bye", "\n", ",")

return M
