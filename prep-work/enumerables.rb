!class Array
    def my_each(&prc)
        prc ||= Proc.new{|element| element}
        idx = 0
        while idx < self.length
            prc.call(self[idx])
            idx += 1
        end
        self
    end

    def my_each_with_index(&prc)
        prc ||= Proc.new{|element| element}
        idx = 0
        while idx < self.length
            prc.call(self[idx], idx)
            idx += 1
        end
        self
    end

    def my_select(&prc)
        selected_elements = []
        self.my_each do |el|
            selected_elements << el if prc.call(el)
        end
        return selected_elements
    end

    def my_reject(&prc)
        selected_elements = []
        self.my_each do |el|
            selected_elements << el if !prc.call(el)
        end
        return selected_elements
    end

    def my_any?(&prc)
        self.my_each do |el|
            return true if prc.call(el)
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |el|
            return false if !prc.call(el)
        end
        true
    end

    # TODO: flatten does not work

    # def my_flatten(val = self)
    #     if val.kind_of?(Array) && val.none? { |elem| elem.kind_of?(Array)}
    #         return val
    #     else
    #         return my_flatten(val)
    #     end
    # end

    # p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
    # p [1, 2, 3].my_flatten 
    # p [1, 2, 3, [4]].my_flatten 


    def my_zip(*args)
        zipped_array = []
        (0...self.length).each do |idx|
            zipped_element = []
            zipped_element << self[idx]
            args.each do |element|
                zipped_element << element[idx]
            end
            zipped_array << zipped_element
        end
        zipped_array
    end

    def my_rotate(rotation_val = 1)
        if rotation_val == 0
            return
        end
        rotated_array = self.map(&:clone)
        if rotation_val > 0
            (0...rotation_val).each do
                shifted_val = rotated_array.shift
                rotated_array << shifted_val
            end
        else
            (rotation_val...0).each do
                popped_val = rotated_array.pop
                rotated_array.unshift(popped_val)
            end
        end
        rotated_array
    end

    def my_join(seperator = '')
        joined_string = ''
        self.my_each_with_index do |char, i|
            joined_string += char
            if i < self.length - 1
                joined_string += seperator
            end
        end
        joined_string
    end

    def my_reverse
        reversed_arr = self.map(&:clone)
        (0...reversed_arr.length / 2).each do |idx|
            idx_from_the_end = (idx + 1) * -1
            reversed_arr[idx], reversed_arr[idx_from_the_end] = reversed_arr[idx_from_the_end], reversed_arr[idx]
        end
        reversed_arr
    end

    def bubble_sort(&prc)
        sorted = false
        to_sort = self.map(&:clone)
        while !sorted
            sorted = true
            (0...to_sort.length - 1).each do |i|
                if prc.call(to_sort[i], to_sort[i+1]) > 0
                    sorted = false
                    to_sort[i], to_sort[i+1] = to_sort[i+1], to_sort[i]
                end
            end
        end
        to_sort
    end

    def bubble_sort!(&prc)
        sorted = false
        while !sorted
            sorted = true
            (0...self.length - 1).each do |i|
                if prc.call(self[i], self[i+1]) > 0
                    sorted = false
                    self[i], self[i+1] = self[i+1], self[i]
                end
            end
        end
        self
    end
end
a = [1, 10, 3, 5]
p a.bubble_sort { |num1, num2| num1 <=> num2 } #sort ascending
p a
p [3, 3, 2, 5].bubble_sort { |num1, num2| num2 <=> num1 } #sort descending
p '++++++++++++++'
b=[1, 20, 3, 5]
p b.bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
p b
p [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending


# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.

def factors(num)
    factors = []
    (1..num).each do |i| 
        factors << i if num % i === 0
    end
    factors
end

def substrings(string)
    substring_arr = []
    (0...string.length).each do |idx1|
        substring = ''
        substring += string[idx1]
        substring_arr << substring
        (idx1 + 1...string.length).each do |idx2|
            substring += string[idx2]
            substring_arr << substring
        end
    end
    substring_arr
end

p substrings("cat") # => ["c", "ca", "cat", "a", "at", "t"]
p substrings("phantom")


def subwords(word, dictionary)
    substring_arr = []
    (0...word.length).each do |idx1|
        substring = ''
        substring += word[idx1]
        substring_arr << substring if dictionary.include?(substring)
        (idx1 + 1...word.length).each do |idx2|
            substring += word[idx2]
            substring_arr << substring if dictionary.include?(substring)
        end
    end
    substring_arr
end

p subwords('supercalifragilisticexpialidocious', DICTIONARY)