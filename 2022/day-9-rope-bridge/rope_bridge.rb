require_relative 'helpers'

moves = []

File.foreach('motion_data.txt') do |line|
  line = line.strip.split
  moves << [line[0], line[1].to_i]
end

# Each key is a y-pos, each value is an array of x-pos visited at that y-pos
grid = { 0 => [0] }

head = [0, 0]
# Part 1
# tail = [0, 0]
# Part 2
tails = Array.new(9) { [0, 0] }

moves.each do |move|
  move[1].times do
    # Part 1
    # new_positions = move_rope(head, [tail], move[0])
    # head = new_positions[0]
    # tail = new_positions[1].first
    # grid[tail[1]] ? grid[tail[1]] << tail[0] : grid[tail[1]] = [tail[0]]

    # Part 2
    new_positions = move_rope(head, tails, move[0])
    head = new_positions[0]
    tails = new_positions[1]
    # Register last tail's position in grid
    grid[tails[8][1]] ? grid[tails[8][1]] << tails[8][0] : grid[tails[8][1]] = [tails[8][0]]
  end
end

count = 0

grid.each_value { |x_values| count += x_values.uniq.count }

p count
