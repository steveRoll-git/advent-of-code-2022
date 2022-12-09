local input = io.open("input.txt", "r")

local priorities = {}
for i = ("a"):byte(), ("z"):byte() do
  priorities[string.char(i)] = i - ("a"):byte() + 1
end
for i = ("A"):byte(), ("Z"):byte() do
  priorities[string.char(i)] = i - ("A"):byte() + 27
end

local sum = 0

for l in input:lines("*l") do
  local firstHalf = {}
  for i = 1, #l / 2 do
    firstHalf[l:sub(i,i)] = true
  end
  for i = #l / 2 + 1, #l do
    local c = l:sub(i, i)
    if firstHalf[c] then
      sum = sum + priorities[c]
      break
    end
  end
end

print(sum)