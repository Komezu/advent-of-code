def move_rope(head, tails, direction)
  # Associate each movement direction to vector
  directions = { 'L' => [-1, 0], 'R' => [1, 0], 'U' => [0, 1], 'D' => [0, -1] }

  # Move head using vector
  head = head.zip(directions[direction]).map(&:sum)
  tails = move_tails(head, tails)

  [head, tails]
end

def move_tails(head, tails)
  tails.each do |tail|
    # If head and tail do not touch (more than one space away in any direction)
    if (head[0] - tail[0]).abs > 1 || (head[1] - tail[1]).abs > 1
      # Move tail towards head when apart by two spaces in movement axis or one space in opposite axis
      tail[0] -= 1 if head[0] - tail[0] <= -1
      tail[0] += 1 if head[0] - tail[0] >= 1
      tail[1] += 1 if head[1] - tail[1] >= 1
      tail[1] -= 1 if head[1] - tail[1] <= -1
    end

    # Assign tail that was just considered as the next head
    head = tail
  end
end
