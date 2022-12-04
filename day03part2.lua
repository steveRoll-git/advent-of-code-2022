local input = io.open("input03.txt", "r")

local priorities = {}
for i = ("a"):byte(), ("z"):byte() do
  priorities[string.char(i)] = i - ("a"):byte() + 1
end
for i = ("A"):byte(), ("Z"):byte() do
  priorities[string.char(i)] = i - ("A"):byte() + 27
end

local sum = 0

local count = 0
local group = {{}, {}}

for l in input:lines("*l") do
  if count == 2 then
    for i = 1, #l do
      local c = l:sub(i, i)
      if group[1][c] and group[2][c] then
        sum = sum + priorities[c]
        break
      end
    end
  else
    for i = 1, #l do
      group[count + 1][l:sub(i, i)] = true
    end
  end
  count = (count + 1) % 3
  if count == 0 then
    group = {{}, {}}
  end
end

print(sum)