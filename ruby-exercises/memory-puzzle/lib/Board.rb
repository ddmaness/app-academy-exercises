require_relative './Card.rb'


class Board
    def initialize(grid_size)
        @size = self.force_grid_size_to_even(grid_size)
        @grid = Array.new(@size) {Array.new(@size)}
        self.populate
    end

    def force_grid_size_to_even(grid_size)
        grid_size += 1 if grid_size % 2 != 0
        grid_size
    end

    def calculate_number_of_pairs
        number_of_pairs = (@size ** 2) / 2
    end

    def generate_shuffled_pair_list(number_of_pairs)
        alph = ('A'..'Z').to_a
        pair_list = []
        number_of_pairs.times {|i| pair_list << alph[i] << alph[i]}
        pair_list.shuffle!
    end

    def populate
        pair_list = self.generate_shuffled_pair_list(self.calculate_number_of_pairs)
        @size.times do |row|
            @size.times {|col|  @grid[row][col] = Card.new(pair_list.shift) }
        end
        @grid
    end

    def render
        output = "  "
        @size.times {|i| output += "#{i} "}
        output += "\n"
        @size.times do |i|
            output += "#{i} "
            @size.times {|j| output += "#{@grid[i][j].display_value || " "} "}
            output += "\n"
        end
        print output
    end
    
    def win?
        @grid.flatten.all? {|card| card.face_up}
    end

    def get_card(pos)
        row, col = pos
        @grid[row][col]
    end

    def reveal(pos)
        card = get_card(pos)
        if !card.face_up
            card.reveal
            self.render
            card.face_value
        end
    end

    def hide(pos)
        card = get_card(pos)
        if card.face_up
            card.hide
        end
    end

    def check_value(pos)
        card = get_card(pos)
        card.face_value
    end

end
