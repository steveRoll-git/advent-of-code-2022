local function key(x, y)
	return ("%d,%d"):format(x, y)
end

local function sign(x)
	return x < 0 and -1 or (x > 0 and 1 or 0)
end

local input = io.open("input09.txt", "r")

local directions = {
	L = {x = -1, y = 0},
	R = {x = 1, y = 0},
	U = {x = 0, y = -1},
	D = {x = 0, y = 1},
}

local visited = {[key(0, 0)] = true}
local visitedCount = 1

local pieces = {}
for i = 1, 10 do
	table.insert(pieces, {x = 0, y = 0})
end

local function movePiece(i, x, y)
	local piece = pieces[i]
	local prevX, prevY = piece.x, piece.y
	piece.x = x
	piece.y = y
	if i == #pieces then
		local k = key(piece.x, piece.y)
		if not visited[k] then
			visited[k] = true
			visitedCount = visitedCount + 1
		end
	elseif i < #pieces then
		local nextPiece = pieces[i + 1]
		local deltaX = piece.x - nextPiece.x
		local deltaY = piece.y - nextPiece.y
		if math.abs(deltaX) >= 2 or math.abs(deltaY) >= 2 then
			local targetX = nextPiece.x + sign(deltaX)
			local targetY = nextPiece.y + sign(deltaY)
			movePiece(i + 1, targetX, targetY)
		end
	end
end

for l in input:lines("*l") do
	local direction, amount = l:match("(.) (%d*)")
	amount = tonumber(amount)
	local dir = directions[direction]
	for i = 1, amount do
		movePiece(1, pieces[1].x + dir.x, pieces[1].y + dir.y)
	end
end

print(visitedCount)