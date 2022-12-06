local function allDifferent(str)
	local seen = {}
	for i=1, #str do
		local c = str:sub(i, i)
		if seen[c] then
			return false
		end
		seen[c] = true
	end
	return true
end

local input = io.open("input06.txt", "r"):read("*a")

local back = 14

for i = 1, #input - back do
	if allDifferent(input:sub(i, i + back - 1)) then
		print(i + back - 1)
		break
	end
end