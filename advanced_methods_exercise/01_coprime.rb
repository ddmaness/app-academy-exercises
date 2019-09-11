# Write a method, coprime?(num_1, num_2), that accepts two numbers as args.
# The method should return true if the only common divisor between the two numbers is 1.
# The method should return false otherwise. For example coprime?(25, 12) is true because
# 1 is the only number that divides both 25 and 12.
def coprime?(num_1, num_2)
    divisors = Hash.new(0)
    getFactors(num_1).each { |num| divisors[num] += 1 }
    getFactors(num_2).each { |num| divisors[num] += 1 }
    divisors.values.each do |val|
        if val > 1
            return false
        end
    end
    true
end

def getFactors(num)
    arr = []
    (2...num).each do |el|
        if num % el == 0
            arr << el
        end
    end
    return arr
end

p coprime?(25, 12)    # => true
p coprime?(7, 11)     # => true
p coprime?(30, 9)     # => false
p coprime?(6, 24)     # => false
