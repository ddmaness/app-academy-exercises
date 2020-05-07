require 'byebug'

def select_even_nums(arr)
    return arr.select(&:even?)
end

def reject_puppies(arr)
    return arr.reject { |dog| dog['age'] <= 2}
end

def count_positive_subarrays(arr)
    return arr.count do |sub_arr| 
        total = sub_arr.reduce {|a, el| a + el }
        total > 0 
    end
end

def aba_translate(str)
    vowels = 'aeiou'
    new_str = str.split('').map! do |c|
        if vowels.include?(c)
            c + 'b' + c
        else
            c
        end
    end
    new_str.join('')
end

def aba_array(arr)
    arr.map { |word| aba_translate(word) }
end