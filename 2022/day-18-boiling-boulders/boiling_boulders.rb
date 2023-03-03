require_relative 'helpers'

droplet = {}

# Part 2 only
x_values = []
y_values = []
z_values = []

File.foreach('droplet_data.txt') do |line|
  line = line.strip.split(',').map(&:to_i)
  droplet[line] = 6

  # Part 2 only
  x_values << line[0]
  y_values << line[1]
  z_values << line[2]
end

# Part 1

droplet.each do |cube, sides|
  x, y, z = cube
  adj_cubes = [[x - 1, y, z], [x + 1, y, z], [x, y - 1, z], [x, y + 1, z], [x, y, z - 1], [x, y, z + 1]]

  # Subtract exposed sides by 1 for every adjacent cube
  adj_cubes.each { |c| sides -= 1 if droplet[c] }

  droplet[cube] = sides
end

p droplet.values.sum

# Part 2

fill_area = {}

# Create a fill area one unit bigger than droplet in every direction
(x_values.min - 1..x_values.max + 1).each do |x|
  (y_values.min - 1..y_values.max + 1).each do |y|
    (z_values.min - 1..z_values.max + 1).each do |z|
      # Set everything in fill area to unfilled value of 0
      fill_area[[x, y, z]] = 0
    end
  end
end

# Set starting point of flood fill to cube with smallest coordinates
p flood_fill([x_values.min - 1, y_values.min - 1, z_values.min - 1], fill_area, droplet)
