# frozen_string_literal: true

require 'cell'

RSpec.describe Cell do
  describe '.initialize' do
    it('initializes with no mine') do
      cell = Cell.new
      expect(cell.has_mine).to be false
    end
  end
  describe '.plant_bomb' do
    it('sets .has_mine to true') do
      cell = Cell.new
      expect(cell.has_mine).to be false
      cell.plant_bomb
      expect(cell.has_mine).to be true
    end
  end
  describe '.show' do
    it('shows the state of @hidden') do
      cell = Cell.new
      expect(cell.has_mine).to be false
      cell.plant_bomb
      expect(cell.has_mine).to be true
    end
  end
  describe '.hidden?' do
    it('shows the state of @hidden') do
      cell = Cell.new
      expect(cell.hidden?).to be true
      cell.show
      expect(cell.hidden?).to be false
    end
  end
  describe '.has_mine?' do
    it('shows the state of @hidden') do
      cell = Cell.new
      expect(cell.has_mine?).to be false
      cell.plant_bomb
      expect(cell.has_mine?).to be true
    end
  end
end
