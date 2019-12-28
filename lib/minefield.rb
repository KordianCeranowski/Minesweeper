# frozen_string_literal: true

# Class for keeping game board
class Minefield
  attr_accessor :width, :height, :mine_count

  def initialize(width, height, mine_percent)
    @width = width
    @height = height
    @mine_count = width * height * mine_percent * 0.01
  end
end
