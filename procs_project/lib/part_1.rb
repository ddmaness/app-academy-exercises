def my_map(arr, &block)
    new_arr = []
    arr.each { |el| new_arr << block.call(el) }
    new_arr
end

def my_select(arr, &block)
    new_arr = []
    arr.each do |el|
        if block.call(el)
            new_arr << el
        end
    end
    new_arr
end

def my_count(arr, &block)
    count = 0
    arr.each do |el|
        if block.call(el)
            count += 1
        end
    end
    count
end

def my_any?(arr, &block)
    arr.each do |el|
        return true if block.call(el)
    end
    false
end

def my_all?(arr, &block)
    arr.each do |el|
        return false if !block.call(el)
    end
    true
end

def my_none?(arr, &block)
    arr.each do |el|
        return false if block.call(el)
    end
    true
end