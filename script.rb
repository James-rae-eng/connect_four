require 'io/console'

class Player
    attr_reader :name, :symbol
    def initialize(name, symbol)
        @name = name
        @symbol = symbol
    end
end

class Board
    def initialize()
        @slots = Array.new(6) {Array.new(7,"\u{25EF}")}
    end

    def display_board
        joined_row = @slots.map {|nest| nest.join(" ")}
        joined_row.unshift(["1 2 3 4 5 6 7"])
        puts joined_row.reverse
    end

    def add_counter(selection, current_player)
        done = 0
        @slots.map do |row|
            if row[(selection-1)] == "\u{25EF}" && done == 0
                row[(selection-1)] = current_player.symbol
                done += 1
            end
        end
    end

    def valid_move?(selection)
        @slots[5][(selection-1)] != "\u{25EF}" ? false : true
    end

    def board_full?
        @slots[5].include?("\u{25EF}") ? false : true
    end

    def row_win(symbol)
        @slots.each do |row|
            row.each_cons(4) do |four_slots|
                return true if four_slots.all? {|slot| slot == symbol}
            end
        end
        return false
    end

    def column_win(symbol)
        0.upto(5) do |i|
            column = [@slots[0][i], @slots[1][i], @slots[2][i], @slots[3][i], @slots[4][i], @slots[5][i]]
            column.each_cons(4) do |four_slots|
                return true if four_slots.all? {|slot| slot == symbol}
            end
        end
        return false
    end

    def right_dia_win(symbol)
        #complete this
        return false
    end

    def left_dia_win(symbol)
        #complete this
        return false
    end
end

class Game
    def initialize (current_player = nil)
        @current_player = current_player
        @board = Board.new
    end

    def welcome_message
        puts "\nLet's play Connect four!

        \nThis is a 2 player game, you will each enter your name and be given a symbol disk.
        \nI'm going to assume you know the rules, good luck!

        \nPress any key to continue.\n"
        STDIN.getch
        puts "\n"
    end


    def player_name(number, symbol)
        puts "Please enter player #{number}'s name."
        name = gets.chomp
        Player.new(name, symbol)
    end

    def player_set_up
        symbol_1 = "\u{25CD}"
        symbol_2 = "\u{25CF}"
        @player_1 = player_name(1, symbol_1)
        @player_2 = player_name(2, symbol_2)
        @current_player = @player_1
    end

    def switch_player
        if @current_player == @player_1
            @current_player = @player_2
        else
            @current_player = @player_1
        end
    end

    def valid_selection?(selection)
        if selection.to_s.length >= 2 
            false
        elsif selection == 8 || selection == 9 || selection == 0
            false
        else 
            true
        end     
    end

    def player_turn
        puts "#{@current_player.name} please type in a column number to add your counter."
        while selection = gets.chomp.to_i
            case
            when valid_selection?(selection) == false || @board.valid_move?(selection) == false
                puts "invalid selection, please choose again"
            else
                break
            end
        end
        @board.add_counter(selection, @current_player)
        @board.display_board
    end

    def check_winner
        s = @current_player.symbol
        if @board.row_win(s) == true || @board.column_win(s) == true || @board.right_dia_win(s) == true || @board.left_dia_win(s) == true
            true
        else
            false
        end
    end

    def game_over?
        if @board.board_full? == true
            true
        elsif check_winner == true
            true
        else 
            false
        end
    end

    def display_winner
        puts "\n#{@current_player.name} is the winner!"
    end

    def play
        welcome_message
        player_set_up
        puts "Here is an example board:"
        @board.display_board
        until game_over? == true do
            switch_player
            player_turn
        end
        display_winner
    end
end

game = Game.new
game.play
