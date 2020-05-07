def partition(args, num)
    less = []
    eq_or_greater = []
    args.each do |el|
        if el < num 
            less << el
        else
            eq_or_greater << el
        end
    end
    [less, eq_or_greater]
end

def merge(hash_1, hash_2)
    merged = Hash.new
    hash_1.each { |k, v| merged[k] = v }
    hash_2.each { |k, v| merged[k] = v }
    merged
end

def censor(sentence, curses)
    vowels = 'aeiou'
    arr = sentence.split(' ').each do |word|
        if curses.include?(word.downcase)
            word.each_char.with_index do |l, idx|
                if vowels.include?(l.downcase)
                    word[idx] = '*'
                end
            end
        end
    end
    arr.join(' ')
end

def power_of_two?(num)
    count = 2
    if num == 1 
        return true
    end
    while count <= num
        if count == num
            return true
        else
            count = count * 2
        end
    end
    false
end