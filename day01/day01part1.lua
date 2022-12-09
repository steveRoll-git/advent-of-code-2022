local input = io.open("input.txt", "r")

local count = 0
local largest = 0

for l in input:lines("*l") do
  if l == "" then
    largest = math.max(count, largest)
    count = 0
  else
    count = count + tonumber(l)
  end
end

print(largest)