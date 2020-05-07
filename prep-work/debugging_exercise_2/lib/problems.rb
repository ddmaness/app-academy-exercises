# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

require "byebug"

def isPrime?(num)
    factor = 2
    (factor...num).each do |i|
        return false if num % i == 0
    end
    true
end

def largest_prime_factor(num)
    i = num
    while i > 0
        if num % i == 0
            return i if isPrime?(i)
        end
        i -= 1
    end
end

def unique_chars?(str)
    char_hash = Hash.new(0)
    str.each_char do |c|
        char_hash[c] += 1
    end
    char_hash.each_value do |v|
        return false if v > 1 
    end
    true
end

def dupe_indices(arr)
    dupe_hash = Hash.new() {[]}
    arr.each_with_index do |item, i|
        dupe_hash[item] = dupe_hash[item] << i
    end
    return dupe_hash.select! do |k, v|
        v.length > 1
    end
end

def ana_array(arr1, arr2)
    arr1.each do |el|
        return false if !arr2.include?(el)
    end
    arr2.each do |el|
        return false if !arr1.include?(el)
    end
    return true
end