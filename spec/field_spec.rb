# frozen_string_literal: true

require 'field'

RSpec.describe Field do
  describe '.initialize' do
    context 'when creating new object has no mine' do
      field = Field.new()
      expect(field.has_mine).to be false
    end
  end
end
