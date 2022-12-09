local input = io.open("input.txt", "r")

local score = 0

local translate = {
  X = "A",
  Y = "B",
  Z = "C"
}

local counts = {
  A = 1,
  B = 2,
  C = 3,
}

local wins = {
  A = "C",
  B = "A",
  C = "B"
}

for l in input:lines("*l") do
  local opponent, me = l:match("(.) (.)")
  me = translate[me]
  if opponent == me then
    score = score + 3
  else
    if wins[me] == opponent then
      score = score + 6
    end
  end
  score = score + counts[me]
end

print(score)
