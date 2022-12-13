require 'json'
require_relative 'helpers'

# Part 1
pairs = []
current = []

# Part 2
packets = []

File.foreach('packet_data.txt') do |line|
  line = line.strip

  if line == ''
    pairs << current
    current = []
  else
    # Use json gem to convert string input into array
    current << JSON.parse(line)
    packets << JSON.parse(line)
  end
end

# Add last pair without trailing blank line to pairs array
pairs << current

indices = []
# compare_pair will return -1 if in order, 0 if no decision, 1 if not in order
pairs.each_with_index { |pair, index| indices << index + 1 if compare_pair(pair[0], pair[1]) == -1 }

p indices.sum

packets.push([[2]], [[6]])
# Sort packets by comparing them in pairs
packets.sort! { |a, b| compare_pair(a, b) }

p (packets.index([[2]]) + 1) * (packets.index([[6]]) + 1)
