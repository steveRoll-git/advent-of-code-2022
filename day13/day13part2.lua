local input = io.open("input.txt", "r")

local next = input:lines("*l")

local function compare(left, right)
	if type(left) == "number" then
		left = {left}
	elseif type(right) == "number" then
		right = {right}
	end
	
	for i = 1, math.max(#left, #right) do
		local l, r = left[i], right[i]
		if not l then
			return true
		elseif not r then
			return false
		elseif type(l) == "table" or type(r) == "table" then
			local result = compare(l, r)
			if result ~= nil then
				return result
			end
		elseif l ~= r then
			return l < r
		end
	end
end

local all = {}

while true do
	local left = next()
	left = loadstring("return " .. left:gsub("%[", "{"):gsub("%]", "}"))()
	local right = next()
	right = loadstring("return " .. right:gsub("%[", "{"):gsub("%]", "}"))()
	
	table.insert(all, left)
	table.insert(all, right)
	
	if not next() then
		break
	end
end

local divider1 = {{2}}
local divider2 = {{6}}

table.insert(all, divider1)
table.insert(all, divider2)

table.sort(all, compare)

local ind1, ind2

for i, e in ipairs(all) do
	if e == divider1 then
		ind1 = i
	elseif e == divider2 then
		ind2 = i
	end
	if ind1 and ind2 then
		break
	end
end

print(ind1 * ind2)