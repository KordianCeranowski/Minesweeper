# frozen_string_literal: true

# class for single field of minefield
class Field
  attr_accessor :has_mine, :sign, :hidden
  def initialize
    @has_mine = false
    @hidden = true
  end
end
