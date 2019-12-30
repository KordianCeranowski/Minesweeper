# frozen_string_literal: true

require 'cell'

RSpec.describe Cell do
  describe '.initialize' do
    it('initializes with no mine') do
      cell = Cell.new
      expect(cell.has_mine).to be false
    end
  end
end
