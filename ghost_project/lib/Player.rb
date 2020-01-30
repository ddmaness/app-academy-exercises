class Player
    def initialize(name)
        @name = name
    end
    def name
        @name
    end
    def guess
        gets.chomp.downcase
    end
    def alert_invalid_guess
        p "I'm sorry, #{@name} but this is an invalid guess"
    end
end