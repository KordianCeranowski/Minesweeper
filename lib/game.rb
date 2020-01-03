# frozen_string_literal: true

require_relative 'minefield'

# Class for running a game
class Game
  attr_accessor :board, :round_counter

  def self.start
    @board = Minefield.new(13, 13, 15)

    print "\n----------------------\n"
    print "--- FIRST ROUND ---"
    print "\n----------------------\n"
    @board.print_empty_board

    print('Choose field to uncover: ')
    first_field = Game.letters_to_coordinates(gets.chomp)
    print("\n")

    @board.prepare_board(first_field)
    @board.refresh_visibility
    @board.print_board

    Game.loop_game
  end

  def self.loop_game
    round_counter = 2
    until @board.game_lost
      field = Game.read_coordinates
      @board.uncover(field)
      @board.refresh_visibility
      if @board.game_lost
        Game.lose(field)
      else
        Game.continue_playing(round_counter)
      end
    end
  end

  def self.continue_playing(round_counter)
    print "\n----------------\n"
    print '--- ROUND ' + round_counter.to_s + ' ---'
    print "\n----------------\n"
    round_counter += 1
    @board.print_board
  end

  def self.lose(field)
    print "\n----------------------\n"
    print '--- ): YOU LOST :( ---'
    print "\n----------------------\n"
    @board.print_lost_board(field)
  end

  def self.read_coordinates
    print('Choose field to uncover: ')
    field = Game.letters_to_coordinates(gets.chomp)
    print("\n")
    field
  end

  def self.letters_to_coordinates(text)
    text.upcase.split('').map { |letter| letter.ord - 65 }
  end

  def self.minefield_from_input
    # ilość pól od 3 do 26
    puts('Podaj wymiary mapy')
    puts('- ile rzędów?: ')
    rows = gets.chomp
    puts('- ile kolumn?: ')
    columns = gets.chomp
    print('Ile procent min?: ')
    mines = gets.chomp
    Minefield.new(rows, columns, mines)
  end
end

Game.start