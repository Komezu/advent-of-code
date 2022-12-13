def find_existing_neighbors(square)
  directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  # Find squares left, right, up and down of current square
  neighbors = directions.map { |direction| direction.zip(square).map(&:sum) }

  # Remove square if out of bounds of grid
  neighbors.reject do |neighbor|
    neighbor[0].negative? || neighbor[0] > C_COUNT - 1 || neighbor[1].negative? || neighbor[1] > R_COUNT - 1
  end
end

def can_visit?(square, previous, heightmap, visited)
  return false if visited[square] == true
  # If elevation of square is more than one level higher, cannot move to it
  return false if LEVELS.index(heightmap[square[1]][square[0]]) - LEVELS.index(heightmap[previous[1]][previous[0]]) > 1

  true
end

def backwards_can_visit?(square, previous, heightmap, visited)
  return false if visited[square] == true
  # If elevation of square is more than one level lower, cannot move to it
  return false if LEVELS.index(heightmap[square[1]][square[0]]) - LEVELS.index(heightmap[previous[1]][previous[0]]) < -1

  true
end
