local input = io.open("input.txt", "r"):read("*a")

local width, height = 93, 41

local function at(x, y)
  return x + y * width
end

local function inside(x, y)
  return x >= 0 and x < width and y >= 0 and y < height
end

local heightMap = {}

local startX, startY
local endX, endY

do
  local y = 0
  for l in input:gmatch("[^\n]+") do
    for i = 1, #l do
      local x = i - 1
      local tile = l:sub(i, i)
      if tile == "S" then
        startX = x
        startY = y
        heightMap[at(x, y)] = 0
      elseif tile == "E" then
        endX = x
        endY = y
        heightMap[at(x, y)] = 25
      else
        heightMap[at(x, y)] = tile:byte() - ("a"):byte()
      end
    end
    y = y + 1
  end
end

local fillMap = {}

local directions = {
  {x = 1, y = 0},
  {x = -1, y = 0},
  {x = 0, y = 1},
  {x = 0, y = -1},
}

local function fillFrom(x, y, steps)
  local tile = heightMap[at(x, y)]
  for _, dir in ipairs(directions) do
    local fx, fy = x + dir.x, y + dir.y
    if fx == endX and fy == endY then
      fillMap[at(fx, fy)] = steps + 1
      return
    end
    if inside(fx, fy) and heightMap[at(fx, fy)] - tile <= 1 and (not fillMap[at(fx, fy)] or fillMap[at(fx, fy)] > steps) then
      fillMap[at(fx, fy)] = steps
      fillFrom(fx, fy, steps + 1)
    end
  end
end

for y = 0, height - 1 do
  for x = 0, width - 1 do
    if heightMap[at(x, y)] == 0 then
      fillMap[at(x, y)] = 0
      fillFrom(x, y, 1)
    end
  end
end

local currentX, currentY = endX, endY
local stepsTaken = 0

repeat
  local nextX, nextY
  local bestTile = math.huge
  for _, d in ipairs(directions) do
    local nx, ny = currentX + d.x, currentY + d.y
    if inside(nx, ny) and fillMap[at(nx, ny)] and fillMap[at(nx, ny)] < bestTile and fillMap[at(currentX, currentY)] - fillMap[at(nx, ny)] <= 1 then
      nextX, nextY = nx, ny
      bestTile = fillMap[at(nx, ny)]
    end
  end
  stepsTaken = stepsTaken + 1
  currentX, currentY = nextX, nextY
until heightMap[at(currentX, currentY)] == 0

print(stepsTaken)