require_relative 'helpers'

cave = {}

File.foreach('scan_data.txt') do |line|
  line = line.strip.split(' -> ').map { |point| point.split(',').map(&:to_i) }

  # Iterate over each pair of points and mark rock path in cave
  (1...line.length).each do |i|
    mark_rock_path(line[i - 1], line[i], cave)
  end
end

x_values = cave.keys.sort { |a, b| a[0] <=> b[0] }
smallest_x = x_values.first[0]
biggest_x = x_values.last[0]

y_values = cave.keys.sort { |a, b| a[1] <=> b[1] }
biggest_y = y_values.last[1]
# Part 2
floor_y = biggest_y + 2

# Part 2: draw cave with only rock paths
draw_map('initial_cave.txt', cave, smallest_x, biggest_x, floor_y)

# Initiate sand unit at entry point
sand = [500, 0]
at_rest = 0

# Part 1: check whether sand went out of bounds
# until sand[0] < smallest_x || sand[0] > biggest_x || sand[1] > biggest_y
# Part 2: check whether entry point got blocked by sand
until cave[[500, 0]]
  next_y = sand[1] + 1

  # Part 2: check if sand is already on the floor
  if next_y == floor_y
    cave[sand] = 'o'
    at_rest += 1
    sand = [500, 0]
    next
  end

  # Try falling straight first
  if !cave[[sand[0], next_y]]
    sand = [sand[0], next_y]
  # Then try falling left if not possible
  elsif !cave[[sand[0] - 1, next_y]]
    sand = [sand[0] - 1, next_y]
  # Then try falling right if not possible
  elsif !cave[[sand[0] + 1, next_y]]
    sand = [sand[0] + 1, next_y]
  # Sand is at rest if cannot fall in any direction, so mark its resting position
  else
    cave[sand] = 'o'
    at_rest += 1
    sand = [500, 0]
  end
end

# Part 2: draw cave filled with sand after updating x values range
x_values = cave.keys.sort { |a, b| a[0] <=> b[0] }
smallest_x = x_values.first[0]
biggest_x = x_values.last[0]
draw_map('filled_cave.txt', cave, smallest_x, biggest_x, floor_y)

p at_rest
