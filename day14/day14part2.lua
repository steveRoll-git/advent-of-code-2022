local input = io.open("input.txt", "r")

local function at(x, y)
	return ("%d,%d"):format(x, y)
end

local rock = {}

local bottom = 0

for l in input:lines("*l") do
	local lastX, lastY
	for x, y in l:gmatch("(%d+),(%d+)") do
		x, y = tonumber(x), tonumber(y)
		bottom = math.max(bottom, y)
		if lastX then
			for ix = lastX, x, lastX > x and -1 or 1 do
				for iy = lastY, y, lastY > y and -1 or 1 do
					rock[at(ix, iy)] = true
				end
			end
		end
		lastX, lastY = x, y
	end
end

local sand = {}

local function free(x, y)
	local i = at(x, y)
	return y < bottom + 2 and not rock[i] and not sand[i]
end

local rested = 0

local startX, startY = 500, 0

while true do
	local x, y = startX, startY
	while true do
		if free(x, y + 1) then
			x, y = x, y + 1
			--print("down")
		elseif free(x - 1, y + 1) then
			x, y = x - 1, y + 1
			--print("left")
		elseif free(x + 1, y + 1) then
			x, y = x + 1, y + 1
			--print("right")
		else
			rested = rested + 1
			sand[at(x, y)] = true
			if x == startX and y == startY then
				goto done
			end
			break
		end
	end
end
::done::

print(rested)