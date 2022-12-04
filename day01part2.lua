local input = io.open("input01.txt", "r")

local count = 0
local largest = {}

for l in input:lines("*l") do
  if l == "" then
    table.insert(largest, count)
    table.sort(largest)
    if #largest > 3 then
      table.remove(largest, 1)
    end
    count = 0
  else
    count = count + tonumber(l)
  end
end

print(largest[1] + largest[2] + largest[3])