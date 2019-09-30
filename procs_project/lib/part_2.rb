def reverser(str, &block)
    block.call(str.reverse)
end

def word_changer(sentence, &block) 
    sentence.split(' ').map { |word| block.call(word) }.join(' ')
end

def greater_proc_value(num, proc1, proc2)
    if proc1.call(num) > proc2.call(num)
        proc1.call(num)
    else
        proc2.call(num)
    end
end

def and_selector(arr, proc1, proc2)
    arr.select {|el| proc1.call(el) && proc2.call(el)}
end

def alternating_mapper(arr, proc1, proc2)
    new_arr =[]
    arr.each_with_index do |el, index|
        if index % 2 == 0
            new_arr << proc1.call(el)
        else
            new_arr << proc2.call(el)
        end
    end
    new_arr
end