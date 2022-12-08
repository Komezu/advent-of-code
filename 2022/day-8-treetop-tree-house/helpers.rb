def tree_visible?(r_index, c_index)
  # Check if visible from left, right, top or bottom
  GRID[r_index][0..c_index - 1].max < GRID[r_index][c_index] ||
    GRID[r_index][c_index + 1..C_COUNT - 1].max < GRID[r_index][c_index] ||
    TRANSPOSED[c_index][0..r_index - 1].max < TRANSPOSED[c_index][r_index] ||
    TRANSPOSED[c_index][r_index + 1..R_COUNT - 1].max < TRANSPOSED[c_index][r_index]
end

def calc_scenic_score(r_index, c_index)
  left = 0
  right = 0
  top = 0
  bottom = 0

  # Iterate through trees to each side of current tree (reversed array for easier iteration for left and top)
  # Count visible trees and break iteration if view stops there

  GRID[r_index][0..c_index - 1].reverse_each do |tree|
    tree < GRID[r_index][c_index] ? left += 1 : (break left += 1)
  end

  GRID[r_index][c_index + 1..C_COUNT - 1].each do |tree|
    tree < GRID[r_index][c_index] ? right += 1 : (break right += 1)
  end

  TRANSPOSED[c_index][0..r_index - 1].reverse_each do |tree|
    tree < GRID[r_index][c_index] ? top += 1 : (break top += 1)
  end

  TRANSPOSED[c_index][r_index + 1..R_COUNT - 1].each do |tree|
    tree < GRID[r_index][c_index] ? bottom += 1 : (break bottom += 1)
  end

  left * right * top * bottom
end
