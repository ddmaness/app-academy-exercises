def palindrome?(str)
    orginal_str = ''
    str.each_char {|l| orginal_str += l}
    i = 0
    while i <= (str.length - 1)  / 2.0
        str[i], str[(i + 1) * -1] = str[(i + 1) * -1], str[i]
        i += 1
    end
    orginal_str == str
end

def substrings(str)
    i = 0
    substrings_arr = []
    substring = ''
    (0..str.length-1).each do |i|
        substring += str[i]
        substrings_arr << substring
        (i+1..str.length-1).each do |j| 
            substring += str[j]
            substrings_arr << substring
        end
        substring = ''
    end
    substrings_arr
end

def palindrome_substrings(str)
    arr = substrings(str)
    arr.select! { |el|  el.length > 1 && palindrome?(el) }
end