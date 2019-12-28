# frozen_string_literal: true

require 'minefield'

RSpec.describe Field do
  describe '.initialize' do
    it('initializes with right mine count') do
      field = Minefield.new(10, 10, 15)
      expect field.mine_count to eq 15
    end
  end
end
