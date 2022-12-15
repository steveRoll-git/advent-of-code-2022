local function at(x, y)
	return ("%d,%d"):format(x, y)
end

local function distance(x1, y1, x2, y2)
  return math.abs(x1 - x2) + math.abs(y1 - y2)
end

local input = io.open("input.txt", "r")

local left, right = math.huge, -math.huge

local sensors = {}

for l in input:lines("*l") do
  local sensorX, sensorY, beaconX, beaconY = l:match("Sensor at x=(%-?%d*), y=(%-?%d*): closest beacon is at x=(%-?%d*), y=(%-?%d*)")
  sensorX = tonumber(sensorX)
  sensorY = tonumber(sensorY)
  beaconX = tonumber(beaconX)
  beaconY = tonumber(beaconY)
  local dist = distance(sensorX, sensorY, beaconX, beaconY)
  table.insert(sensors, {x = sensorX, y = sensorY, beaconX = beaconX, beaconY = beaconY, distance = dist})

  left = math.min(left, sensorX - dist)
  right = math.max(right, sensorX + dist)
end

local y = 2000000

local count = 0

for x = left, right do
  for _, s in ipairs(sensors) do
    if not (x == s.beaconX and y == s.beaconY) and distance(x, y, s.x, s.y) <= s.distance then
      count = count + 1
      break
    end
  end
end

print(count)