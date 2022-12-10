crates = {}

File.foreach('crate_data.txt') do |line|
  # First gsub to account for first stack being shorter (so line starts empty), but was not necessary for my input
  line = line.gsub(/^   /, '[0]').gsub('    ', ' [0]').strip.split

  line.each_with_index do |crate, index|
    # Skip non-existing crates
    next if crate == '[0]'

    # Using unshift as if putting crate at bottom of stack
    crates[index + 1] ? crates[index + 1].unshift(crate) : crates[index + 1] = [crate]
  end
end

moves = []

File.foreach('procedure_data.txt') { |line| moves << line.strip.scan(/[0-9]+/).map(&:to_i) }

moves.each do |move|
  # Part 1
  # move[0].times { crates[move[2]] << crates[move[1]].pop }

  # Part 2
  crates[move[2]] << crates[move[1]].pop(move[0])
  crates[move[2]].flatten!
end

# .sort on a hash returns multidimensional array, iteration similar to hash key-value pairs
top = crates.sort.map { |_, stack| stack.last }

p top.join.gsub(/(\[|\])/, '')
