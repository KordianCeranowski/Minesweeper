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
    it('creates board as a Hash') do
      minefield = Minefield.new(10, 10, 15)
      minefield.fill_map_with_fields
      expect(minefield.board.class).to be Hash
    end
    it('makes board of right size') do
      minefield = Minefield.new(10, 10, 15)
      minefield.fill_map_with_fields
      expect(minefield.board.size).to eq 100
    end
  end
end
