pairs = []

File.foreach('assignment_data.txt') do |line|
  line = line.strip.split(',').map { |elf| elf.split('-').map(&:to_i) }
  pairs << line
end

count1 = 0
count2 = 0

pairs.each do |pair|
  # Creating arrays with all of the sections each elf must clean given the range
  first = (pair[0][0]..pair[0][1]).to_a
  second = (pair[1][0]..pair[1][1]).to_a

  # Part 1
  count1 += 1 if first.intersection(second).length == first.length || first.intersection(second).length == second.length

  # Part 2
  count2 += 1 unless first.intersection(second).empty?
end

p count1
p count2
