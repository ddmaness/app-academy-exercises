require_relative'./Board.rb'
require_relative'./HumanPlayer.rb'
require_relative'./ComputerPlayer.rb'

class Game
    def initialize
        @board = Board.new(6)
        @previous_guess = nil
        @player = ComputerPlayer.new(6)
    end

    def play
        while !self.over?
            @board.render
            @player.prompt
            guess = @player.get_input(@previous_guess)
            guess_pos = parse_input(guess)
            self.make_guess(guess_pos)
            sleep(1)
            system("clear")
        end
        p "You win!"
    end

    def parse_input(input)
        input.chomp
        input_array = input.split(' ')
        input_array.map { |val| val.to_i }
    end

    def make_guess(guess_pos)
        if @previous_guess
            if @board.check_value(@previous_guess) == @board.check_value(guess_pos)
                self.reveal_and_memorize(guess_pos)
            else
                self.reveal_and_memorize(guess_pos)
                @player.check_for_match(@board.check_value(guess_pos))
                @board.hide(guess_pos)
                @board.hide(@previous_guess)
            end
            @previous_guess = nil
        else
            self.reveal_and_memorize(guess_pos)
            @player.check_for_match(@board.check_value(guess_pos))

            @previous_guess = guess_pos
        end
    end

    def reveal_and_memorize(pos)
        revealed_card_value = @board.reveal(pos)
        @player.receive_revealed_card(pos, revealed_card_value)
    end

    def over?
        @board.win?
    end
end

game = Game.new

game.play