# frozen_string_literal: true

require 'minefield'

RSpec.describe Minefield do
  describe '.initialize' do
    it('initializes with right mine count') do
      minefield = Minefield.new(10, 10, 15)
      expect(minefield.mine_count).to eq 15
    end
  end
  describe '.fill_map_with_fields' do
    it('creates hash with fields') do
      minefield = Minefield.new(10, 10, 15)
      minefield.fill_map_with_fields
      expect(minefield.board.class).to be Hash
      expect(minefield.board.size).to eq 100
    end
  end
end
