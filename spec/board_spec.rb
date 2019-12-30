# frozen_string_literal: true

require 'board'

RSpec.describe Board do
  describe '.initialize' do
    it('initializes with right mine count') do
      board = Board.new(10, 10, 15)
      expect(board.mine_count).to eq 15
    end
  end
  describe '.fill_with_fields' do
    it('creates board as a Hash') do
      board = Board.new(10, 10, 15)
      board.fill_with_fields
      expect(board.board.class).to be Hash
    end
    it('makes board of right size') do
      board = Board.new(10, 10, 15)
      board.fill_with_fields
      expect(board.board.size).to eq 100
    end
  end
end
