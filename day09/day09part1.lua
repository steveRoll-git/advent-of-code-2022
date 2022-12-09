local function key(x, y)
	return ("%d,%d"):format(x, y)
end

local input = io.open("input.txt", "r")

local directions = {
	L = {x = -1, y = 0},
	R = {x = 1, y = 0},
	U = {x = 0, y = -1},
	D = {x = 0, y = 1},
}

local visited = {[key(0, 0)] = true}
local visitedCount = 1

local headX, headY = 0, 0
local tailX, tailY = 0, 0

local function moveHead(dx, dy)
	local prevX, prevY = headX, headY
	headX = headX + dx
	headY = headY + dy
	if math.abs(tailX - headX) >= 2 or math.abs(tailY - headY) >= 2 then
		tailX, tailY = prevX, prevY
		local k = key(tailX, tailY)
		if not visited[k] then
			visited[k] = true
			visitedCount = visitedCount + 1
		end
	end
end

for l in input:lines("*l") do
	local direction, amount = l:match("(.) (%d*)")
	amount = tonumber(amount)
	local dir = directions[direction]
	for i = 1, amount do
		moveHead(dir.x, dir.y)
	end
end

print(visitedCount)