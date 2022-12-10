local input = io.open("input.txt", "r")

local cycle = 0

local sum = 0

local x = 1

local function incrementCycle()
  cycle = cycle + 1
  if (cycle - 20) % 40 == 0 then
    sum = sum + cycle * x
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

print(sum)