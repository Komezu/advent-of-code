# Part 1
# MARKER_SIZE = 4
# Part 2
MARKER_SIZE = 14

buffer = []

File.foreach('buffer_data.txt') do |line|
  buffer = line.strip.chars
end

marker_start_index = 0

(0..buffer.length - MARKER_SIZE).each do |index|
  if buffer.slice(index, MARKER_SIZE).uniq.length == MARKER_SIZE
    marker_start_index = index
    break
  end
end

p marker_start_index + MARKER_SIZE
