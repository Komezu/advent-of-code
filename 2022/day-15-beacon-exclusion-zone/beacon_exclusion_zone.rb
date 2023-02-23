require 'set'

# Part 1
TARGET_Y = 2_000_000
# Part 2
MAX_XY = 4_000_000

sensors = []
beacons = Set.new # Part 1 only

File.foreach('sensor_data.txt') do |line|
  match = line.match(/x=(-*[0-9]+), y=(-*[0-9]+).+x=(-*[0-9]+), y=(-*[0-9]+)/)

  manhattan_dist = (match[1].to_i - match[3].to_i).abs + (match[2].to_i - match[4].to_i).abs
  sensors << [[match[1].to_i, match[2].to_i], manhattan_dist]
  beacons.add([match[3].to_i, match[4].to_i]) # Part 1 only
end

# Part 1

no_beacon = Set.new

sensors.each do |sensor, md|
  y_dist = (sensor[1] - TARGET_Y).abs
  # If distance to target y bigger than Manhattan distance, then sensor cannot reach target y at all
  next if md < y_dist

  x_dist = md - y_dist

  # Use remaining distance on x-axis in both directions
  (sensor[0] - x_dist..sensor[0] + x_dist).each do |x|
    no_beacon.add([x, TARGET_Y])
  end
end

# Remove points where there is a known beacon
p no_beacon.subtract(beacons).size

# Part 2

signal = []

(0..MAX_XY).each do |y|
  # Stop iteration if distress signal found
  break unless signal.empty?

  x_ranges = []

  sensors.each do |sensor, md|
    y_dist = (sensor[1] - y).abs
    next if md < y_dist

    x_dist = md - y_dist
    # Determine range of x values covered by sensor for current y
    start_x = (sensor[0] - x_dist).negative? ? 0 : sensor[0] - x_dist
    end_x = sensor[0] + x_dist > MAX_XY ? MAX_XY : sensor[0] + x_dist

    x_ranges << (start_x..end_x)
  end

  x_ranges.sort_by(&:first).reduce do |a, b|
    if b.first > a.last + 1
      # Gap in x values is location of signal
      signal = [a.last + 1, y]
      break
    else
      # Update the checked x range
      (a.first..[a.last, b.last].max)
    end
  end
end

# Multiplier does not change with MAX_XY
p signal[0] * 4_000_000 + signal[1]
