local input = io.open("input.txt", "r"):read("*a")

local width = input:find("\n") - 1
local height = #input / (width + 1)

local function get(x, y)
  local i = y * (width + 1) + x + 1
  return tonumber(input:sub(i, i))
end

local best = 0

for x = 0, width - 1 do
  for y = 0, height - 1 do
    local num = get(x, y)
    local visibleUp = 0
    for vy = y - 1, 0, -1 do
      visibleUp = visibleUp + 1
      if get(x, vy) >= num then
        break
      end
    end
    local visibleDown = 0
    for vy = y + 1, height - 1 do
      visibleDown = visibleDown + 1
      if get(x, vy) >= num then
        break
      end
    end
    local visibleLeft = 0
    for vx = x - 1, 0, -1 do
      visibleLeft = visibleLeft + 1
      if get(vx, y) >= num then
        break
      end
    end
    local visibleRight = 0
    for vx = x + 1, width - 1 do
      visibleRight = visibleRight + 1
      if get(vx, y) >= num then
        break
      end
    end

    local total = visibleUp * visibleDown * visibleLeft * visibleRight
    best = math.max(total, best)
  end
end

print(best)