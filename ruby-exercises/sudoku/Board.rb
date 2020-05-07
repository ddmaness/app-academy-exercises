require_relative('./Tile.rb')
require_relative('./Player.rb')

require('byebug')

class Board
    def initialize(grid)
        @grid = grid
        @player = Player.new
    end

    def self.from_file(file_path)
        file = File.open(file_path)
        file_data = file.readlines.map do |line|
            line_cleaned = line.chomp
            line_arr = line_cleaned.split('')
            line_arr.map! do |value|
                if value.to_i > 0
                    Tile.new(value, true)
                else
                    Tile.new(" ", false)
                end
            end
        end
        file.close
        file_data
    end

    def write_number(input)
        parsed_input = self.parse_player_input(input)
        @grid[parsed_input['position']['row']][parsed_input['position']['col']].set_value(parsed_input['value'])
    end

    def render
        @grid.each do |row|
            row.each do |tile|
                print tile.to_s
            end
            puts
        end
    end

    def solved?
        valid_squares? && valid_columns? && valid_rows?
    end

    def valid_rows?
        results = @grid.all? do |row|
            valid_sequence?(row)
        end
    end

    def valid_columns?
        columns = []
        (0..8).each do |col|
            column = []
            (0..8).each do |row|
                column << @grid[row][col]
            end
            columns << column
        end
        result = columns.all? do |column|
            valid_sequence?(column)
        end
    end

    def valid_squares?
        squares = []
        i = 0
        while i < 8
            j = 0
            while j < 8
                square = []
                3.times do |n|
                    3.times do |t|
                        square << @grid[i+n][j+t]
                    end
                end
                squares << square
                j+=3
            end
            i += 3
        end
        result = squares.all? do |square|
            valid_sequence?(square)
        end
    end

    def valid_sequence?(arr)
        sorted_arr = arr.map {|val| val.value}.sort
        (1..9).each do |i|
            return false if sorted_arr[i-1].to_i != i
        end
    end

    def parse_player_input(input)
        parsed_input = {
            'position' => {
                'row' => nil,
                'col' => nil
            },
            'value' => nil
        }
        input_arr = input.split(' ')
        position = input_arr[0].split(',')
        value = input_arr[1]
        parsed_input['position']['row'] = position[0].to_i
        parsed_input['position']['col'] = position[1].to_i
        parsed_input['value'] = value
        parsed_input        
    end

    def play
        until self.solved?
            self.render
            input = @player.prompt
            self.write_number(input)
            # system('clear')
        end
        self.render
        p "you win!"
    end
end

board = Board.new(Board.from_file('puzzles/sudoku1_almost.txt'))
board.play