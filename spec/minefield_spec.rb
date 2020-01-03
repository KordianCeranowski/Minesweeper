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

  describe '.print_alphabet' do
    it 'prints alphabet with spaces' do
      expect {
        Minefield.new(0, 0, 0).print_alphabet
      }
        .to output("  A B C D E F G H I J K L M N O P Q R S T U V W X Y Z\n")
        .to_stdout
    end
  end

  describe '.print_this_letter' do
    it 'prints chosen letter of english alphabet' do
      minefield = Minefield.new(0, 0, 0)
      expect { minefield.print_this_letter(0) }.to output('A ').to_stdout
      expect { minefield.print_this_letter(1) }.to output('B ').to_stdout
      expect { minefield.print_this_letter(2) }.to output('C ').to_stdout
      expect { minefield.print_this_letter(25) }.to output('Z ').to_stdout
    end
  end


  describe '.count_mines' do
    minefield = Minefield.new(3, 3, 0)
    minefield.fill_board_with_cells
    minefield.fill_board_with_zeroes

    minefield.board[[0, 0]].plant_bomb
    minefield.board[[2, 2]].plant_bomb
    minefield.count_mines
    context 'before choosing a cell' do
      it 'prints empty board' do
        expect { minefield.print_board }
          .to output("  A B C\nA _ _ _ \nB _ _ _ \nC _ _ _ \n")
          .to_stdout
      end
    end
    context 'after choosing a cell' do
      it 'shows number on this cell' do
        minefield.uncover([1, 1])
        expect { minefield.print_board }
          .to output("  A B C\nA _ _ _ \nB _ 2 _ \nC _ _ _ \n")
          .to_stdout
      end
    end
  end

  describe '.print_empty_board' do
    it 'prints empty board' do
      expect {
        Minefield.new(4, 4, 4).print_empty_board
      }
        .to output("  A B C D\nA _ _ _ _ \nB _ _ _ _ \nC _ _ _ _ \nD _ _ _ _ \n")
        .to_stdout
    end
  end

  describe '.neighbouring_visible_zero' do
    context 'while there are visible zeroes' do
      it 'returns true' do
        mock_cell = instance_double('Cell')
        minefield = Minefield.new(1, 2, 0);

        minefield.board[[0, 0]] = mock_cell
        minefield.board[[0, 1]] = Cell.new
        minefield.board[[0, 1]].count_of_mines_around = 0
        minefield.board[[0, 1]].show

        function_output = minefield.neighbouring_visible_zero(0, 0)

        expect(function_output).to be true
      end
    end
    context 'while there are no visible zeroes' do
      it 'returns true' do
        mock_cell = instance_double('Cell')
        minefield = Minefield.new(1, 2, 0);

        minefield.board[[0, 0]] = mock_cell
        minefield.board[[0, 1]] = Cell.new

        function_output = minefield.neighbouring_visible_zero(0, 0)

        expect(function_output).to be false
      end
    end
  end

  describe '.refresh_visibility' do
    context 'while there are visible zeroes' do
      it 'some cells recive :show' do
        minefield = Minefield.new(1, 2, 0)
        minefield.board[[0, 0]] = Cell.new
        minefield.board[[0, 1]] = Cell.new
        minefield.board[[0, 1]].count_of_mines_around = 0
        minefield.board[[0, 1]].show

        minefield.refresh_visibility
        expect(minefield.board[[0, 0]].hidden).to be false
      end
    end
  end

  describe '.uncover' do
    it 'changes @game_lost to true after uncovering cell with a bomb' do
      minefield = Minefield.new(10, 10, 15)

      expect(minefield.game_lost).to be false

      mock_cell = instance_double('Cell')
      allow(mock_cell).to receive(:show)
      allow(mock_cell).to receive(:has_mine?).and_return(true)

      minefield.board[[1, 1]] = mock_cell

      minefield.uncover([1, 1])

      expect(minefield.game_lost).to be true
    end
  end

  describe '.print_lost_board' do
    context 'after setting @game_lost to true' do
      it 'prints whole map with mines visible' do
        minefield = Minefield.new(5, 5, 0)
        minefield.prepare_board([0, 0])
        minefield.uncover([0, 0])
        expect {
          minefield.print_lost_board([0, 0])
        }
          .to output("  A B C D E\nA X _ _ _ _ \nB _ _ _ _ _ \nC _ _ _ _ _ \nD _ _ _ _ _ \nE _ _ _ _ _ \n")
          .to_stdout
      end
    end
  end
end
