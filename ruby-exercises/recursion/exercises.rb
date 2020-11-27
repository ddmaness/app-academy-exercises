require('byebug')

def range(start_val, end_val)
    return [] if start_val >= end_val
    return [start_val] if start_val == end_val - 1
    [start_val] + range(start_val + 1, end_val)
end

# tests
# p range(1, 5)
# p range(4, 2)
# p range(3, 3)
# p range(44, 77)

def exp_v_1(num, pow)
    return 1 if pow === 0
    return num * exp_v_1(num, pow - 1)
end

# p exp_v_1(3, 3)

def exp_v_2(num, pow)
    return 1 if pow === 0
    return num if pow === 1
    return exp_v_2(num, pow / 2) * exp_v_2(num, pow / 2) if pow.even?
    return num * ((exp_v_2(num, (pow -1) / 2)) * (exp_v_2(num, (pow -1) / 2))) if pow.odd?
end

# tests
# p exp_v_2(1, 0)
# p exp_v_2(1, 1)
# p exp_v_2(1, 2)
# p exp_v_2(2, 0)
# p exp_v_2(2, 1)
# p exp_v_2(2, 2)
# p exp_v_2(2, 3)
# p exp_v_2(5, 5)



class Array
    def deep_dup
        duped_array = []
        self.each do |elem|
            if elem.is_a? Array
                duped_array << elem.deep_dup
            else
                duped_array << elem
            end
        end
        return duped_array
    end
end


# robot_parts = [
#     "a",
#     [   
#         ['some', 'test', 'items'],
#         "nuts", 
#         "bolts", 
#         "washers"
#     ],
#     ["capacitors", "resistors", "inductors"],
#     "b"

# ]

# robot_parts_copy = robot_parts.deep_dup

# shouldn't modify robot_parts
# robot_parts_copy[2] << "LEDs"
# robot_parts[1][0] << "new item"

# p 'og'
# p robot_parts[2] # => ["capacitors", "resistors", "inductors"]

# p 'cpy'
# p robot_parts_copy[2] # => ["capacitors", "resistors", "inductors", "LEDs"]
# p '###########'
# p 'og'
# p robot_parts
# p 'cpy'
# p robot_parts_copy

# arr = [1, [2], [3, [4]]]
# arr_copy = arr.deep_dup

# p arr
# p arr_copy
# arr_copy[2][1] << 'test'
# p arr
# p arr_copy

def iterative_fib (num)
    fib_arr = []
    (1..num).each do |i|
        if i == 1 || i == 2
            fib_arr << 1
        else
            fib_arr << fib_arr[-1] + fib_arr[-2]
        end
    end
    fib_arr
end


def recursive_fib (n)
    return [1] if n == 1
    return [1, 1] if n == 2
    seq = recursive_fib(n-1)
    next_el = seq[-1] + seq[-2]
    seq << next_el
    seq
end

# p recursive_fib(6)

def bsearch(array, target)
    middle_index = (array.length - 1) / 2
    if array.length == 0
        return nil
    end
    if array[middle_index] == target
        return middle_index
    elsif array[middle_index] > target
        if bsearch(array[0...middle_index], target)
            return middle_index + (bsearch(array[0...middle_index], target) - middle_index)
        else
            return nil
        end
    else
        if bsearch(array[(middle_index + 1)..-1], target)
            return middle_index + 1 + bsearch(array[(middle_index + 1)..-1], target)
        else
            return nil
        end
    end
end

# test cases
# p bsearch([1, 3, 4, 5, 9], 4) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 3, 4, 5, 9], 9) # => 4
# p bsearch([1, 3, 4, 5, 9, 11, 12, 14], 12) # => 6
# p bsearch([1, 3, 4, 5, 9, 11, 12, 14], 4) # => 2
# p bsearch([1, 3, 4, 5, 9], 3) # => 1
# p bsearch([1, 3, 4, 5, 9], 1) # => 0
# p bsearch([1, 3, 4, 5, 9, 11, 12, 14], 3) # => 1
# p bsearch([1, 3, 4, 5, 9, 11, 12, 14, 15], 9) # => 4
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def merge_sort(array)
    middle_index = (array.length - 1) / 2
    if array.length == 0 || array.length == 1
        return array
    end
    first_half = merge_sort(array[0..middle_index])
    last_half = merge_sort(array[middle_index + 1..array.length - 1])
    return merge(first_half, last_half)
end

def merge(array_1, array_2) 
    sorted_array = []
    while array_1.length > 0 || array_2.length > 0
        if array_1[0] && array_2[0]
            array_1[0] <= array_2[0] ? sorted_array << array_1.shift : sorted_array << array_2.shift
        elsif array_1[0]
            sorted_array << array_1.shift
        else
            sorted_array << array_2.shift 
        end
    end
    return sorted_array
end

# tests
# p merge_sort([1])
# p merge_sort([])
# p merge_sort([2, 1])
# p merge_sort([4, 3, 1, 2])
# p merge_sort([1100, 1, 32, 11, 424, 22, 11, 11, 22, 20])

def subsets(array)
    if array.length <= 1
        return array
    end
    subset_array = []
    (0..array.length - 1).each do |i|
        subset_array << subsets(array[0...i]) << subsets(array[0...i]).concat([array[-1]])
    end
    return subset_array
end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3]) # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

def permutations(array)
    
end

p permutations([1, 2])
p permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]