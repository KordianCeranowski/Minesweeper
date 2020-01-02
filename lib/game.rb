# frozen_string_literal: true

require_relative 'minefield'

# Class for running a game
class Game
  def self.start
    # puts('Jak duża mapa?')
    # puts('- ile rzędów?: ')
    # rows = gets.chomp
    # puts('- ile kolumn?: ')
    # columns = gets.chomp
    # print('Ile procent min?: ')
    # mines = gets.chomp

    # board = Minefield.new(rows, columns, mines)
    board = Minefield.new(3, 3, 15)
# ilość pól od 3 do 26
    round_counter = 1
    print "\n----------------------\n"
    print "--- FIRST ROUND ---"
    print "\n----------------------\n"
    round_counter += 1
    board.print_empty_board

    print('Choose field to uncover: ')
    first_field = Game.letters_to_coordinates(gets.chomp)
    print("\n")

    board.prepare_board(first_field)
    board.refresh_visibility
    board.print_board

    # game loop
    until board.game_lost

      print('Choose field to uncover: ')
      field = Game.letters_to_coordinates(gets.chomp)
      print("\n")

      board.uncover(field)
      board.refresh_visibility
      if board.game_lost
        print "\n----------------------\n"
        print "--- ): YOU LOST :( ---"
        print "\n----------------------\n"
        board.print_lost_board(field)
      else
        print "\n----------------\n"
        print "--- ROUND " + round_counter.to_s + " ---"
        print "\n----------------\n"
        round_counter += 1
        board.print_board
      end
    end
  end

  def self.letters_to_coordinates(text)
    text.upcase.split('').map { |letter| letter.ord - 65 }
  end
end

Game.start