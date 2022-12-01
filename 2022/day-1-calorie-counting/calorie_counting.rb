elves = []
calories = 0

File.foreach("calorie_data.txt") do |line|
  line = line.strip

  if line == ""
    elves << calories
    calories = 0
  else
    calories += line.to_i
  end
end

# To account for the last elf without a trailing blank line
elves << calories

p elves.sort.last(3).sum
