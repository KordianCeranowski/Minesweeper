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
        expect(value.count_of_mines_around).to eq 0
      end
    end
  end

  describe '.count_mines' do
    it 'sets @count_of_mines_around to the right value' do
      minefield = Minefield.new(3, 3, 0)
      minefield.fill_board_with_cells
      minefield.fill_board_with_zeroes

      minefield.board[[0, 0]].plant_bomb
      minefield.board[[2, 2]].plant_bomb

      minefield.count_mines

      (0..2).each do |row|
        (0..2).each do |col|
          if (row == 0 && col == 0) || (row == 2 && col == 2)
            expect(minefield.board[[row, col]].count_of_mines_around).to eq 9
          elsif (row == 0 && col == 2) || (row == 2 && col == 0)
            expect(minefield.board[[row, col]].count_of_mines_around).to eq 0
          elsif row == 1 and col == 1
            expect(minefield.board[[row, col]].count_of_mines_around).to eq 2
          else
            expect(minefield.board[[row, col]].count_of_mines_around).to eq 1
          end
        end
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
