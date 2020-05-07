require 'byebug'

class Board
    def initialize (n)
       @grid = Array.new(n) {Array.new(n, :N)} 
       @size = n * n
    end

    def size
        @size
    end

    def [] (arr)
        @grid[arr[0]][arr[1]]
    end

    def []= (pos, val)
        @grid[pos[0]][pos[1]] = val
    end

    def num_ships
        count = 0 
        @grid.each do |arr|
            arr.each do |val|
                count += 1 if val === :S
            end
        end
        count
    end
    
    def attack (pos)
        if self[pos] == :S
            self[pos] = :H 
            p 'you sunk my battleship!'
            true
        else
            self[pos] = :X
            false
        end
    end

    def place_random_ships
        num_to_randomize = @size * 0.25
        randomized_positions = []
        dimension = Math.sqrt(@size).round
        counter = 0
        while counter < num_to_randomize do
            pos = [rand(0...dimension), rand(0...dimension)]
            unless randomized_positions.include?(pos)
                randomized_positions << pos
                counter += 1
            end
        end
        randomized_positions.each do |position|
            self[position] = :S
        end
    end

    def hidden_ships_grid
        hidden_ships = @grid.map(&:clone)
        hidden_ships.map! do |arr|
            arr.map! do |ship| 
                if ship == :S
                    ship = :N
                end
                ship
            end
        end
        return hidden_ships
    end
    
    def self.print_grid (arr)
        arr.each do |sub_arr|
            puts sub_arr.join(' ')
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(self.hidden_ships_grid)
    end
end
