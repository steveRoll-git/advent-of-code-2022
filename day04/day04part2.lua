local input = io.open("input.txt", "r")

local count = 0

for l in input:lines("*l") do
  local a1, b1, a2, b2 = l:match("(%d*)-(%d*),(%d*)-(%d*)")
  a1 = tonumber(a1)
  a2 = tonumber(a2)
  b1 = tonumber(b1)
  b2 = tonumber(b2)
  if a1 <= b2 and a2 <= b1 then
    count = count + 1
  end
end

print(count)