local TestTable = {
	aaa = 1,
	bbb = nil,
	[5] = {
	},
	['ccc'] = {},
}
function serialize(tbl)
    if tbl == nil then
		return 'nil'
	end

	if type(tbl) == 'string' then
		return '\'' .. tbl .. '\''
	elseif type(tbl) ~= 'table' then
		return tbl
	end

	-- table
	local str_table = {}
	function recurse_table(tbl, prefix)
		for k,v in pairs(tbl) do
			local key = type(k) == 'number' and '[' .. k .. ']' or k
			if type(v) == 'table' then 
				table.insert(str_table, prefix .. key .. ' = {\n') 
				recurse_table(v, prefix .. '    ')
				table.insert(str_table, prefix .. '},\n')
			elseif type(v) == 'string' then
				table.insert(str_table, prefix .. key .. ' = \'' .. v .. '\',\n')
			else
				table.insert(str_table, prefix .. key .. ' = ' .. v .. ',\n')
			end
		end
	end

	table.insert(str_table, '{\n')
	recurse_table(tbl, '    ')
	table.insert(str_table, '}\n')
	return table.concat(str_table)
end

local ser_str = serialize(TestTable)
print(ser_str)
