# frozen_string_literal: true

# Class for keeping game board
class Minefield
  attr_accessor :width, :height, :mine_count, :board

  def initialize(width, height, mine_percent)
    @width = width
    @height = height
    @mine_count = width * height * mine_percent * 0.01
  end

  def fill_map_with_fields()
    @board = Hash.new
    for i in 1..@width do
      for j in 1..@height do
        board[[i,j]] = Field.new
      end
    end
  end
end
