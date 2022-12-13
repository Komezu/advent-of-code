def compare_pair(left, right)
  # Compare integers directly
  if left.is_a?(Integer) && right.is_a?(Integer)
    left <=> right
  # Iterate through arrays to compare each element with recursion
  elsif left.is_a?(Array) && right.is_a?(Array)
    # Only compare until end reached for one (or both) of the arrays
    comparable_length = [left.length, right.length].min

    (0...comparable_length).each do |index|
      result = compare_pair(left[index], right[index])
      # At any point, if the order is decided (-1 or 1), return it
      return result if result != 0
    end

    # If end of comparable length reached and no decision, compare array lengths
    left.length <=> right.length
  else
    # Turn the integer side into an array (flatten will not have any effect on non-multidimensional array)
    left = [left].flatten(1)
    right = [right].flatten(1)
    # Recursive call to compare both sides as arrays
    compare_pair(left, right)
  end
end
