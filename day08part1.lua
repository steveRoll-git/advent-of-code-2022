local input = io.open("input08.txt", "r"):read("*a")

local width = input:find("\n") - 1
local height = #input / (width + 1)

local function get(x, y)
  local i = y * (width + 1) + x + 1
  return tonumber(input:sub(i, i))
end

local count = 0

for x = 0, width - 1 do
  for y = 0, height - 1 do
    local num = get(x, y)
    local visibleUp = true
    for vy = y - 1, 0, -1 do
      if get(x, vy) >= num then
        visibleUp = false
        break
      end
    end
    local visibleDown = true
    for vy = y + 1, height - 1 do
      if get(x, vy) >= num then
        visibleDown = false
        break
      end
    end
    local visibleLeft = true
    for vx = x - 1, 0, -1 do
      if get(vx, y) >= num then
        visibleLeft = false
        break
      end
    end
    local visibleRight = true
    for vx = x + 1, width - 1 do
      if get(vx, y) >= num then
        visibleRight = false
        break
      end
    end

    if visibleUp or visibleDown or visibleLeft or visibleRight then
      count = count + 1
    end
  end
end

print(count)