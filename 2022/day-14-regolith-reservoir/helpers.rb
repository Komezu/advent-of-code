def mark_rock_path(a, b, map)
  # When two points have the same x value
  if a[0] == b[0]
    min_y = [a[1], b[1]].min
    max_y = [a[1], b[1]].max

    (min_y..max_y).each do |y|
      map[[a[0], y]] = '█'
    end
  # When two points have the same y value
  elsif a[1] == b[1]
    min_x = [a[0], b[0]].min
    max_x = [a[0], b[0]].max

    (min_x..max_x).each do |x|
      map[[x, a[1]]] = '█'
    end
  end
end

def draw_map(filepath, map, min_x, max_x, floor)
  File.open(filepath, 'w') do |file|
    (0...floor).each do |y|
      # Leave one empty space on each side
      (min_x - 1..max_x + 1).each do |x|
        map[[x, y]].nil? ? file.write(' ') : file.write(map[[x, y]])
      end
      file.write("\n")
    end
    # Print the floor with one extra tile on each side
    file.write('█' * (max_x - min_x + 3))
  end
end
