require_relative 'helpers'

grid = []

File.foreach('map_data.txt') do |line|
  grid << line.strip.chars.map(&:to_i)
end

GRID = grid.freeze
# Transpose grid to make it easier to iterate through a column
TRANSPOSED = grid.transpose.freeze

R_COUNT = GRID.length
C_COUNT = TRANSPOSED.length

# Part 1
visible = 0
# Part 2
max_scenic_score = 0

GRID.each_with_index do |row, r_index|
  # Skip first and last rows as always visible and no scenic score
  next if r_index.zero? || r_index == R_COUNT - 1

  row.each_index do |c_index|
    # Skip first and last columns as always visible and no scenic score
    next if c_index.zero? || c_index == C_COUNT - 1

    # Part 1
    visible += 1 if tree_visible?(r_index, c_index)

    # Part 2
    score = calc_scenic_score(r_index, c_index)
    max_scenic_score = score if score > max_scenic_score
  end
end

# Part 1
p visible + R_COUNT * 2 + (C_COUNT - 2) * 2

# Part 2
p max_scenic_score
