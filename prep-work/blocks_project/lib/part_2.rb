def all_words_capitalized?(arr)
    arr.all? {|word| word == word.capitalize}
end

def no_valid_url?(arr)
    url_endings = ['.com', '.net', '.io', '.org']
    arr.none? do |str|
        str_arr = str.split('.') 
        if url_endings.include?('.' + str_arr[str_arr.length - 1])
            true
        else
            false
        end
    end
end

def any_passing_students?(arr)
    arr.any? do |student|
        if student[:grades].reduce { |a, el| a + el } / student[:grades].length >= 75
            true
        else
            false
        end
    end
end