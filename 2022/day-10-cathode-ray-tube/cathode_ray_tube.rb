# Key is cycle number, value is X's value during that cycle
x_values = {}
cycle = 1
current_value = 1

File.foreach('program_data.txt') do |line|
  if line.strip.match('noop')
    x_values[cycle] = current_value
    cycle += 1
  end

  if (match = line.match(/addx (-*[0-9]+)/))
    2.times do
      x_values[cycle] = current_value
      cycle += 1
    end

    # Update the current X value after two cycles
    current_value += match[1].to_i
  end
end

# Part 1
p [20, 60, 100, 140, 180, 220].map { |k| k * x_values[k] }.sum

# Part 2

pixels = []

x_values.each do |cyc, v|
  position = cyc - 1
  sprite = [v - 1, v, v + 1]

  # Sprite only has horizontal position ranging from 0 to 39
  pixels[position] = sprite.include?(position % 40) ? '#' : '.'
end

row_start = 0

File.open('image.txt', 'w') do |file|
  6.times do
    file.write("#{pixels[row_start, 40].join}\n")
    row_start += 40
  end
end
