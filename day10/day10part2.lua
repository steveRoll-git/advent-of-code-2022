local input = io.open("input.txt", "r")

local x = 1

local screenWidth = 40
local screenHeight = 6
local currentX = 0
local currentY = 0

local function incrementCycle()
  if math.abs(x - currentX) <= 1 then
    io.write("#")
  else
    io.write(".")
  end
  currentX = currentX + 1
  if currentX >= screenWidth then
    currentX = 0
    currentY = currentY + 1
    print()
  end
end

for l in input:lines("*l") do
  local instruction, operand = l:match("(%S*) ?(.*)")
  if instruction == "addx" then
    incrementCycle()
    incrementCycle()
    x = x + tonumber(operand)
  else
    incrementCycle()
  end
end

print()