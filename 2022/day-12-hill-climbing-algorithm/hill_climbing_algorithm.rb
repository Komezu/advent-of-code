require 'English'
require_relative 'helpers'

heightmap = []
start = [] # Part 1 only
goal = []

File.foreach('heightmap_data.txt') do |line|
  line = line.strip.chars

  # Find [x, y] coordinates for S
  if line.include?('S')
    start = [line.index('S'), $INPUT_LINE_NUMBER - 1] # Part 1 only
    # S point has same elevation as 'a'
    line[line.index('S')] = 'a'
  end

  # Find [x, y] coordinates for E
  if line.include?('E')
    goal = [line.index('E'), $INPUT_LINE_NUMBER - 1]
    # E point has same elevation as 'z'
    line[line.index('E')] = 'z'
  end

  heightmap << line
end

# Use letter index as elevation
LEVELS = ('a'..'z').to_a

R_COUNT = heightmap.length
C_COUNT = heightmap.first.length

# BFS: create a queue to store all squares to visit
queue = [goal] # [start] for part 1
# Mark squares as visited to avoid backtracking
visited = { goal => true } # { start => true } for part 1

steps = 0
# Number of squares accessible at n steps away from start (on same layer)
squares_current_step = 1
# Number of squares accessible at n+1 steps away from start
squares_next_step = 0

until queue.empty?
  # Dequeue in order
  current = queue.shift
  # Part 1
  # break if current == goal
  # Part 2: break as soon as any 'a' is reached, as looking for the fewest steps required
  break if heightmap[current[1]][current[0]] == 'a'

  neighbors = find_existing_neighbors(current)

  neighbors.each do |square|
    next unless backwards_can_visit?(square, current, heightmap, visited) # can_visit? for part 1

    queue << square
    # Mark square as visited as soon as enqueued, to avoid duplicated enqueuing
    visited[square] = true
    squares_next_step += 1
  end

  squares_current_step -= 1

  next unless squares_current_step.zero?

  # If current layer finished without reaching goal, increment steps and move to next layer
  squares_current_step = squares_next_step
  squares_next_step = 0
  steps += 1
end

p steps
