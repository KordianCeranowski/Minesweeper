# frozen_string_literal: true

require_relative 'cell'

# Class for keeping game minefield
class Minefield
  attr_accessor :col_count, :row_count, :mine_count, :board, :game_lost, :alphabet

  def initialize(col_count, row_count, mine_percent)
    @col_count = col_count.to_i
    @row_count = row_count.to_i
    @mine_count = @col_count * @row_count * mine_percent.to_i * 0.01
    @game_lost = false
  end

  def prepare_board(excepted_cell)
    fill_board_with_cells
    randomly_plant_bombs(excepted_cell[0], excepted_cell[1])
    fill_board_with_zeroes
    count_mines
  end

  def fill_board_with_cells
    @board = Hash.new(Cell.new)
    (0..@row_count - 1).each do |row|
      (0..@col_count - 1).each do |col|
        @board[[row, col]] = Cell.new
      end
    end
  end

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

  def fill_board_with_zeroes
    (1..@row_count).each do |row|
      (1..@col_count).each do |col|
        @board[[row, col]].count_of_mines_around = 0
      end
    end
  end

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

  def count_mines
    (0..@row_count - 1).each do |row|
      (0..@col_count - 1).each do |col|
        unless @board[[row, col]].has_mine
          @board[[row, col]].count_of_mines_around = count_mines_around_cell(row, col)
        end
      end
    end
  end

  #do faktycznej gry
  def print_board
    print "  " + (10...36).map{ |i| i.to_s 36}.map(&:upcase)[0..col_count].product([' ']).flatten(1)[0...-1].join
    print("\n")
    (0..@row_count - 1).each do |row|
      print (10...36).map{ |i| i.to_s 36}.map(&:upcase)[row] + " "
      (0..@col_count - 1).each do |col|
        if @board[[row, col]].hidden
          print('_ ')
        else
          print(@board[[row, col]].count_of_mines_around.to_s + ' ')
        end
      end
      print("\n")
    end
  end

  # pierwsze drukowanie
  def print_empty_board
    print "  " + (10...36).map{ |i| i.to_s 36}.map(&:upcase)[0..col_count].product([' ']).flatten(1)[0...-1].join
    print("\n")
    (0..@row_count - 1).each do |row|
      print (10...36).map{ |i| i.to_s 36}.map(&:upcase)[row] + " "
      (0..@col_count - 1).each do
        print('_ ')
      end
      print("\n")
    end
  end

  def has_neighbouring_visible_zero2(row, col)
    if !@board[[row + 1, col]].hidden? && @board[[row + 1, col]].count_of_mines_around.zero? then return true end
    if !@board[[row - 1, col]].hidden? && @board[[row - 1, col]].count_of_mines_around.zero? then return true end
    if !@board[[row, col + 1]].hidden? && @board[[row, col + 1]].count_of_mines_around.zero? then return true end
    if !@board[[row, col - 1]].hidden? && @board[[row, col - 1]].count_of_mines_around.zero? then return true end
    false
  end

  def has_neighbouring_visible_zero(row, col)
    (-1..1).each do |row_diff|
      (-1..1).each do |col_diff|
        next if row_diff.zero? && col_diff.zero?
        if !@board[[row + row_diff, col + col_diff]].hidden? && @board[[row + row_diff, col + col_diff]].count_of_mines_around.zero?
          return true
        end
      end
    end
    false
  end

  def refresh_visibility
    something_changed = true
    while something_changed
      something_changed = false
      (0..@row_count - 1).each do |row|
        (0..@col_count - 1).each do |col|
          if @board[[row, col]].hidden?
            if has_neighbouring_visible_zero(row, col)
              @board[[row, col]].show
              something_changed = true
            end
          end
        end
      end
    end
  end

  def uncover(field)
    @board[[field[0], field[1]]].show
    check_for_loosing(field)
  end

  def check_for_loosing(field)
    if @board[[field[0], field[1]]].has_mine?
      @game_lost = true
    end
  end

  # odsłania miny, na zakończenie gry
  def print_lost_board(field)


    print "  " + (10...36).map { |i| i.to_s 36 }.map(&:upcase)[0..col_count].product([' ']).flatten(1)[0...-1].join
    print("\n")

    (0..@row_count - 1).each do |row|
      print (10...36).map{ |i| i.to_s 36}.map(&:upcase)[row] + " "
      (0..@col_count - 1).each do |col|
        if row == field[0] && col == field[1]
          print('X ')
        elsif @board[[row, col]].has_mine?
          print('* ')
        elsif @board[[row, col]].hidden?
          print('_ ')
        else
          print(@board[[row, col]].count_of_mines_around.to_s + " ")
        end
      end
      print("\n")
    end
  end

end
