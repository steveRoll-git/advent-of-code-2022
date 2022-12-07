local input = io.open("input07.txt", "r")

local lines = input:lines("*l")

local line

local function next()
  line = lines()
end

next()

local currentDir = "/"

local sizes = {["/"] = 0}

while line ~= nil do
  if line:sub(1,1) == "$" then
    local command, param = line:match("%$ (..) ?(.*)")
    if command == "cd" then
      if param == "/" then
        currentDir = "/"
      elseif param == ".." then
        currentDir = currentDir:match("(.*/).-/$")
      else
        currentDir = ("%s%s/"):format(currentDir, param)
        sizes[currentDir] = sizes[currentDir] or 0
      end
      next()
    elseif command == "ls" then
      next()
      while line ~= nil and line:sub(1,1) ~= "$" do
        local size, name = line:match("(.*) (.*)")
        if size ~= "dir" then
          local dir = currentDir
          repeat
            sizes[dir] = sizes[dir] + tonumber(size)
            dir = dir:match("(.*/).-/$")
          until dir == nil
        end
        next()
      end
    end
  end
end

local capacity = 70000000
local targetUnusedSpace = 30000000

local usedSpace = sizes["/"]
local unusedSpace = capacity - usedSpace

local bestSize = math.huge

for dir, size in pairs(sizes) do
  if unusedSpace + size >= targetUnusedSpace then
    bestSize = math.min(bestSize, size)
  end
end

print(bestSize)
