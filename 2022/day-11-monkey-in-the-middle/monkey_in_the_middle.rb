monkeys = []
current = {}

File.foreach('monkey_data.txt') do |line|
  line = line.strip

  if (match = line.match(/Starting items: (.+)/))
    current[:items] = match[1].split(', ').map(&:to_i)
    current[:inspected] = 0
  elsif (match = line.match(/Operation: (.+)/))
    # Only keep varying part of operation
    current[:operation] = match[1].split[3..]
  elsif (match = line.match(/Test: divisible by (.+)/))
    current[:divisor] = match[1].to_i
  elsif (match = line.match(/true: throw to monkey (.+)/))
    current[true] = match[1].to_i
  elsif (match = line.match(/false: throw to monkey (.+)/))
    current[false] = match[1].to_i
  elsif line == ''
    monkeys << current
    current = {}
  end
end

# Add last monkey without trailing blank line into array
monkeys << current

# Part 2: calculate least common multiple of divisors
lcm = monkeys.map { |monkey| monkey[:divisor] }.inject { |a, b| a.lcm(b) }

10_000.times do # If part 1: 20.times do
  monkeys.each do |monkey|
    operator = monkey[:operation][0].to_sym
    # If saved (second) operand is also 'old' then no value assigned to operand for now
    operand = monkey[:operation][1].to_i if monkey[:operation][1].match(/[0-9]+/)

    monkey[:items].each do |item|
      # Perform operation on item, using item's own value as second operand if no value previously assigned
      worry = item.public_send(operator, operand.nil? ? item : operand) % lcm # If part 1: / 3 (instead of modulo)

      if (worry % monkey[:divisor]).zero?
        monkeys[monkey[true]][:items] << worry
      else
        monkeys[monkey[false]][:items] << worry
      end
    end

    # Add number of items inspected by monkey during this round to count
    monkey[:inspected] += monkey[:items].count
    # Clear items array as all items have been thrown to others
    monkey[:items] = []
  end
end

# Find two most active monkeys and multiply item count together
p monkeys.map { |monkey| monkey[:inspected] }.max(2).inject(:*)
