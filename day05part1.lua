local input = io.open("input05.txt", "r")

local numStacks = 9

local stacks = {}
for i = 1, numStacks do
  table.insert(stacks, {})
end

local cratesMatchString = (".(.).."):rep(numStacks):sub(1, -2)

local cratesEndString = ""
for i = 1, numStacks do
  cratesEndString = cratesEndString .. (" %d  "):format(i)
end
cratesEndString = cratesEndString:sub(1, -2)

for l in input:lines("*l") do
  if l == cratesEndString then break end

  local cratesThisLine = {l:match(cratesMatchString)}
  for i, crate in ipairs(cratesThisLine) do
    if crate ~= " " then
      table.insert(stacks[i], 1, crate)
    end
  end
end

for l in input:lines("*l") do
  if l == "" then goto continue end

  local amount, from, to = l:match("move (%d*) from (%d) to (%d)")
  amount = tonumber(amount)
  from = tonumber(from)
  to = tonumber(to)
  for i = 1, amount do
    local crate = table.remove(stacks[from])
    table.insert(stacks[to], crate)
  end

  ::continue::
end

for i, stack in ipairs(stacks) do
  io.write(stack[#stack])
end

print()