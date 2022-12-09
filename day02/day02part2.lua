local input = io.open("input.txt", "r")

local score = 0

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

local loses = {
  A = "B",
  B = "C",
  C = "A"
}

for l in input:lines("*l") do
  local opponent, me = l:match("(.) (.)")
  if me == "X" then
    me = wins[opponent]
  elseif me == "Z" then
    me = loses[opponent]
  else
    me = opponent
  end
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