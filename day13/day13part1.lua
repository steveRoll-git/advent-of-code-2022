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

local i = 1

local sum = 0

while true do
	local left = next()
	left = loadstring("return " .. left:gsub("%[", "{"):gsub("%]", "}"))()
	local right = next()
	right = loadstring("return " .. right:gsub("%[", "{"):gsub("%]", "}"))()
	
	if compare(left, right) then
		sum = sum + i
	end
	
	if not next() then
		break
	end
	
	i = i + 1
end

print(sum)