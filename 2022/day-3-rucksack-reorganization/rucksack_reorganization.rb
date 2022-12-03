item_types = ('a'..'z').to_a.concat(('A'..'Z').to_a)

# Part 1
misplaced_items = []

# Part 2
groups = []
trio = []

File.foreach('rucksack_data.txt') do |line|
  line = line.strip.chars

  # Part 1
  first_compartment = line[0..line.length / 2 - 1]
  second_compartment = line[line.length / 2..line.length - 1]
  misplaced_items << first_compartment.intersection(second_compartment)

  # Part 2
  trio << line
  if trio.count == 3
    groups << trio
    trio = []
  end
end

sum1 = 0
misplaced_items.flatten.each { |item| sum1 += item_types.index(item) + 1 }

p sum1

badges = []
groups.each do |group|
  badge = group[0].intersection(group[1], group[2])
  badges << badge
end

sum2 = 0
badges.flatten.each { |badge| sum2 += item_types.index(badge) + 1 }

p sum2
