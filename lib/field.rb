# frozen_string_literal: true

# comment
class Field
  attr_accessor :has_mine, :sign, :hidden
  def initialize
    @has_mine = false
    @hidden = true
  end
end
