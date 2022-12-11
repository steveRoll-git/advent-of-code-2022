local input = io.open("input.txt", "r")
local lines = input:lines("*l")

local monkeys = {}

local line

local function next()
  line = lines()
end

next()

while line ~= nil do
	local monkey = {}
	
	next()
	monkey.items = {}
	local items = line:match(".-: (.*)")
	for item in items:gmatch("(%d+)%D*") do
		table.insert(monkey.items, tonumber(item))
	end
	
	next()
	monkey.operation = loadstring(("return function(old) return %s end"):format(line:match(".-= (.*)")))()
	
	next()
	monkey.test = tonumber(line:match("%D*(%d*)"))
	next()
	monkey.throwTrue = tonumber(line:match("%D*(%d*)")) + 1
	next()
	monkey.throwFalse = tonumber(line:match("%D*(%d*)")) + 1
	next()
	next()
	
	monkey.inspected = 0
	
	table.insert(monkeys, monkey)
end

local function round()
	for i, m in ipairs(monkeys) do
		for i = #m.items, 1, -1 do
			local level = table.remove(m.items, i)
			level = m.operation(level)
			level = math.floor(level / 3)
			local target = (level % m.test == 0) and m.throwTrue or m.throwFalse
			table.insert(monkeys[target].items, level)
			
			m.inspected = m.inspected + 1
		end
	end
end

for i = 1, 20 do
	round()
end

table.sort(monkeys, function(a, b) return a.inspected > b.inspected end)

print(monkeys[1].inspected * monkeys[2].inspected)