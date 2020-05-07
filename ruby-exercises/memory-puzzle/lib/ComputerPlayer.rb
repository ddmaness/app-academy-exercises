class ComputerPlayer
    def initialize(size)
        @known_cards = {}
        @matched_cards = nil
        @size = size
    end

    def check_for_match(value)
        match = []
        @known_cards.each do |k, v|
            match << k if value == v
        end
        @matched_cards = match if match.length == 2
    end

    def receive_revealed_card(pos, val)
        @known_cards[pos] = val
    end

    def prompt
        p "pick a card"
    end

    def get_input(previous_guess)
        if previous_guess
            if @matched_cards
                if @matched_cards[0] == previous_guess
                    guess = @matched_cards[1].join(' ')
                    @matched_cards = nil
                    p guess
                    return guess
                elsif @matched_cards[1] == previous_guess
                    guess = @matched_cards[0].join(' ')
                    @matched_cards = nil
                    p guess
                    return guess
                end
            end
            return self.make_random_guess
        elsif @matched_cards
            p @matched_cards[0].join(' ')
            @matched_cards[0].join(' ')
        else
            return self.make_random_guess
        end
    end

    def make_random_guess
         @size.times do |i|
            @size.times do |j|
                unless @known_cards[[i, j]]
                    p "#{i} #{j}"
                    return "#{i} #{j}"
                end
            end
        end
    end
end