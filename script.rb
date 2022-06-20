require 'io/console'

class Player
    attr_reader :name, :symbol
    def initialize(name, symbol)
        @name = name
        @symbol = symbol
    end
end

class Game

    def welcome_message
        puts "\nLet's play Connect four!

        \nThis is a 2 player game, you will each enter your name and be given a symbol disk.
        \nI'm going to assume you know the rules, good luck!

        \nPress any key to continue.\n"
        STDIN.getch
        puts "\n"
    end


    def player_name(number)
        puts "Please enter player #{number}'s name."
        name = gets.chomp
        Player.new(name, "o")
    end

    


end

#game = Connect_four.new
#game.welcome_message
