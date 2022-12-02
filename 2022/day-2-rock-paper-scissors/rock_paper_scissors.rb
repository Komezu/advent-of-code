opponent = []
# Part 1
me = []
# Part 2
result = []

File.foreach('strategy_data.txt') do |line|
  line = line.strip.split

  case line[0]
  when 'A' then opponent << 1
  when 'B' then opponent << 2
  when 'C' then opponent << 3
  end

  case line[1]
  when 'X'
    me << 1
    result << 0
  when 'Y'
    me << 2
    result << 3
  when 'Z'
    me << 3
    result << 6
  end
end

score1 = 0
score2 = 0

(0..opponent.count - 1).each do |index|
  # Part 1
  score1 += case me[index] - opponent[index]
            # Win
            when 1, -2 then 6 + me[index]
            # Lose
            when -1, 2 then me[index]
            # Draw
            else 3 + me[index]
            end

  # Part 2
  score2 += case result[index]
            # Win
            when 6 then opponent[index] == 3 ? 6 + 1 : 6 + opponent[index] + 1
            # Lose
            when 0 then opponent[index] == 1 ? 3 : opponent[index] - 1
            # Draw
            else 3 + opponent[index]
            end
end

p score1
p score2
