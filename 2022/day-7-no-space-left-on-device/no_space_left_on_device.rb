# Empty string is root file
paths = ['']
directories = {}

File.foreach('terminal_data.txt') do |line|
  if (match = line.match(/^([0-9]+) .+/))
    size = match[1].to_i
    # Add size of file to each dir that contains it, including parents
    paths.each { |path| directories[path] ? directories[path] += size : directories[path] = size }
  # Not necessary to match root file
  elsif (match = line.match(/^\$ cd ([a-z]+)/))
    paths << "#{paths.last}/#{match[1]}"
  elsif line.match(/^\$ cd ../)
    # Remove path to dir and path to its parent becomes last again
    paths.pop
  end
end

# Part 1
p directories.values.reject { |size| size > 100_000 }.sum

# Part 2
to_free = 30_000_000 - (70_000_000 - directories[''])
p directories.values.reject { |size| size < to_free }.min
