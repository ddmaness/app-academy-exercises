class Stack
    def initialize
        @stack = []
    end

    def push(el)
        @stack << el
    end

    def pop
        @stack.pop
    end

    def peek
        @stack.last
    end
end

class Queue
    def initialize
        @queue = []
    end
    def enqueue(el)
        @queue << el
    end
    def dequeue
        @queue.shift
    end
    def peek
        @queue[0]
    end
end

class Map
    def initialize
        @map = []
    end
    def set(key, value)
        @map.each do |pair|
            if pair[0] == key
                pair[1] = value
                return
            end
        end
        @map << [key, value]
    end
    def get(key)
        @map.each do |pair|
            if pair[0] == key
                return pair[1]
            end
        end
        return nil
    end
    def delete(key)
        @map.filter! do |pair|
            pair[0] != key
        end
    end
    def show
        @map.each do |pair|
            puts "#{pair[0]} => #{pair[1]}"
        end
    end
end