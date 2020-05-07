# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
    compressed = []
    count = 1;
    str.split('').each_with_index do |el, idx|
        if el == str[idx+1]
            count += 1
        else
            if count > 1
                compressed << count << el
            else
                compressed << el
            end
            count = 1
        end
    end
    compressed.join('')
end


p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
