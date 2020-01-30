require_relative './Player.rb'
require 'byebug'

class Game
    def initialize(*players)
        @players = players
        @current_player_index = 0
        @previous_player_index = @players.length - 1
        @turns = 0
        @losses = {}
        @players.each {|player| @losses[player.name] = 0}
        @fragment = ''
        @dictionary = Hash.new(0)
        File.foreach("dictionary.txt") { |line| @dictionary[line.chomp] += 1 }
    end
    def next_player!
        @previous_player_index = @current_player_index
        @current_player_index = @turns % @players.length
    end
    def take_turn(player)
        string = player.guess
        if self.valid_play?(string)
            @fragment += string
            if @dictionary[@fragment] > 0
                @losses[@players[@previous_player_index].name] += 1
                if @losses[@players[@previous_player_index].name] > 4
                    p "#{@players[@previous_player_index].name} is now a GHOST and is eliminated"
                    self.eliminate_player(@previous_player_index)
                end
                @fragment = ''
                self.record(@players[@previous_player_index])
            end
            @turns += 1
        else
            player.alert_invalid_guess
        end
    end
    def eliminate_player(index)
        @players.delete_at(index)
    end
    def record(player)
        ghost = 'GHOST'
        p "#{player.name}: #{ghost[0...@losses[player.name]]}"
    end
    def valid_play?(string)
        alpha = ('a'..'z').to_a
        alpha.include?(string) && @dictionary.keys.any? {|key| key.start_with?(@fragment + string)}
    end
    def play_round
        p "#{@players[@current_player_index].name}, make your guess"
        p "Current word fragment: #{@fragment}"
        self.take_turn(@players[@current_player_index])
        self.next_player!
    end
    def display_standings
        @players.each do |player|
            p "++++++++++"
            self.record(player)
        end
    end
    def run
        while @players.length > 1
            self.display_standings
            self.play_round
        end
        p "#{@players[0].name} is the last remaining player, Congrats!"
    end
end

Game.new(Player.new('Donnie'), Player.new('Carrie'), Player.new('Bella')).run
