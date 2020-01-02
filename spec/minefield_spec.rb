# frozen_string_literal: true

require 'minefield'

RSpec.describe Minefield do
  describe '.initialize' do
    it('initializes with right mine count') do
      minefield = Minefield.new(10, 10, 15)
      expect(minefield.mine_count).to eq 15
    end
  end

  describe '.fill_board_with_cells' do
    it('creates board as a Hash') do
      minefield = Minefield.new(10, 10, 15)
      minefield.fill_board_with_cells
      expect(minefield.board.class).to be Hash
    end
    it('makes board of a right size') do
      minefield = Minefield.new(10, 10, 15)
      minefield.fill_board_with_cells
      expect(minefield.board.size).to eq 100
    end
  end

  describe '.randomly_plant_bombs' do
    it('plants exactly as many bombs as needed') do
      minefield = Minefield.new(10, 10, 15)
      minefield.fill_board_with_cells
      minefield.randomly_plant_bombs(0, 0)
    end
  end

  describe '.fill_board_with_zeroes' do
    it('makes all the fields in board have 0 in @count_of_mines_around') do
      minefield = Minefield.new(10, 10, 15)
      minefield.fill_board_with_cells
      minefield.fill_board_with_zeroes

      minefield.board.each do |_key, value|
        # p value.count_of_mines_around
        expect(value.count_of_mines_around).to eq 0
      end
    end
  end

  describe '.uncover' do
    it 'changes @game_lost to true after unocovering cell with bomb by mocking cell' do
      minefield = Minefield.new(10, 10, 15)

      expect(minefield.game_lost).to be false

      cell = instance_double('Cell')
      allow(cell).to receive(:show)
      allow(cell).to receive(:has_mine?).and_return(true)

      minefield.board[[1, 1]] = cell

      minefield.uncover([1, 1])

      expect(minefield.game_lost).to be true
    end
  end
end
