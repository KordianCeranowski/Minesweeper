# frozen_string_literal: true

# class for single cell of minefield
class Cell
  attr_accessor :has_mine, :count_of_mines_around, :hidden
  def initialize
    @has_mine = false
    @hidden = true
    @count_of_mines_around = -1
  end

  def plant_bomb
    @has_mine = true
    @count_of_mines_around = 9
  end

  def show
    @hidden = false
  end

  def hidden?
    hidden
  end

  def has_mine?
    has_mine
  end
end
