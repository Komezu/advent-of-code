def flood_fill(start, area, droplet)
  # Mark starting point as filled and add it to queue
  area[start] = 1
  queue = [start]
  hits = 0

  until queue.empty?
    current = queue.shift

    # Reached a cube from one of its sides exposed to the outside
    if droplet[current]
      hits += 1
      next
    end

    x, y, z = current
    adj_cubes = [[x - 1, y, z], [x + 1, y, z], [x, y - 1, z], [x, y + 1, z], [x, y, z - 1], [x, y, z + 1]]

    adj_cubes.each do |adj|
      # Skip neighboring cube if out of bounds or already filled
      next unless area[adj]&.zero?

      # Mark neighboring cube as filled unless droplet, as we might hit droplet cubes again from different sides
      area[adj] = 1 unless droplet[adj]
      queue << adj
    end
  end

  hits
end
