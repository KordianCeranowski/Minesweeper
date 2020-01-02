# frozen_string_literal: true

require_relative 'cell'

# class for keeping and printing game board
class Minefield
  attr_accessor :col_count, :row_count, :mine_count, :board, :game_lost, :alphabet

  def initialize(col_count, row_count, mine_percent)
    @col_count = col_count.to_i - 1
    @row_count = row_count.to_i - 1
    @mine_count = col_count.to_i * row_count.to_i * mine_percent.to_i * 0.01
    @game_lost = false
    @board = Hash.new(Cell.new)
  end

  # runs all functions needed to starting a game
  def prepare_board(excepted_cell)
    fill_board_with_cells
    randomly_plant_bombs(excepted_cell[0], excepted_cell[1])
    fill_board_with_zeroes
    count_mines
  end

  # sets a cell for every coordinate
  def fill_board_with_cells
    (0..@row_count).each do |row|
      (0..@col_count).each do |col|
        @board[[row, col]] = Cell.new
      end
    end
  end

  # plants bombs randomly, excepting selected cell
  # so player wouldn't loose on the first try
  def randomly_plant_bombs(excepted_row, excepted_col)
    bombs_planted = 0
    @board[[excepted_row, excepted_col]].show
    while bombs_planted < mine_count
      rand_row = rand(@row_count)
      rand_col = rand(@col_count)
      next if rand_row == excepted_row && rand_col == excepted_col

      unless @board[[rand_row, rand_col]].has_mine
        @board[[rand_row, rand_col]].plant_bomb
        bombs_planted += 1
      end
    end
  end

  # sets @count_of_mines_around to zero for all cells in board
  def fill_board_with_zeroes
    (0..@row_count).each do |row|
      (0..@col_count).each do |col|
        unless @board[[row, col]].has_mine?
          @board[[row, col]].count_of_mines_around = 0
        end
      end
    end
  end

  # counts how many cells around selected cell has a mine
  def count_mines_around_cell(row, col)
    sum = 0
    (-1..1).each do |curr_row|
      (-1..1).each do |curr_col|
        next if curr_row.zero? && curr_col.zero?

        if @board[[row + curr_row, col + curr_col]].has_mine?
          sum += 1
        end
      end
    end
    sum
  end

  # sets @count_of_mines_around for each cell in board
  def count_mines
    (0..@row_count).each do |row|
      (0..@col_count).each do |col|
        unless @board[[row, col]].has_mine
          @board[[row, col]]
          .count_of_mines_around = count_mines_around_cell(row, col)
        end
      end
    end
  end

  def print_alphabet
    print(
      '  ' + (10...36)
      .map { |i| i.to_s 36 }
      .map(&:upcase)[0..col_count]
      .product([' '])
      .flatten(1)[0...-1]
      .join
    )
    print("\n")
  end

  def print_this_letter(number)
    print(
      (10...36).map { |i| i.to_s 36 }
      .map(&:upcase)[number] + ' '
    )
  end

  # Prints board during game duration
  def print_board
    print_alphabet
    (0..@row_count).each do |row|
      print_this_letter(row)
      (0..@col_count).each do |col|
        if @board[[row, col]].hidden
          print('_ ')
        else
          print(@board[[row, col]].count_of_mines_around.to_s + ' ')
        end
      end
      print("\n")
    end
  end

  # first printing
  # needed because until first cell selection there is no cell on board
  def print_empty_board
    print_alphabet
    (0..@row_count).each do |row|
      print((10...36).map { |i| i.to_s 36 }.map(&:upcase)[row] + ' ')
      (0..@col_count).each do
        print('_ ')
      end
      print("\n")
    end
  end

#   # checks one of 8 cells neighbours is a visible zero
#   def neighbouring_visible_zero(row, col)
#     (-1..1).each do |row_diff|
#       (-1..1).each do |col_diff|
#         next if row_diff.zero? && col_diff.zero?
#         if !@board[[row + row_diff, col + col_diff]].hidden? &&
#            @board[[row + row_diff, col + col_diff]].count_of_mines_around.zero?
#           return true
#         end
#       end
#     end
#     false
#   end

#   # shows all zeroes that should bee visible after uncovering new cell
#   def refresh_visibility
#     something_changed = true
#     while something_changed
#       something_changed = false
#       (0..@row_count).each do |row|
#         (0..@col_count).each do |col|
#           next unless @board[[row, col]].hidden?

#           if neighbouring_visible_zero(row, col)
#             @board[[row, col]].show
#             something_changed = true
#           end
#         end
#       end
#     end
#   end

  # unhides the chosen cell, then updates game_lost flag
  def uncover(cell)
    @board[[cell[0], cell[1]]].show
    check_for_loosing(cell)
  end

  # sets game_lost flag if one of mines is not hidden
  def check_for_loosing(cell)
    if @board[[cell[0], cell[1]]].has_mine?
      @game_lost = true
    end
  end

#   # shows mines after loosing a game
#   def print_lost_board(cell)
#     print_alphabet

#     (0..@row_count).each do |row|
#       print_this_letter(row)
#       (0..@col_count).each do |col|
#         if row == cell[0] && col == cell[1]
#           print('X ')
#         elsif @board[[row, col]].has_mine?
#           print('* ')
#         elsif @board[[row, col]].hidden?
#           print('_ ')
#         else
#           print(@board[[row, col]].count_of_mines_around.to_s + ' ')
#         end
#       end
#       print("\n")
#     end
#   end
end
