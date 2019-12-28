# frozen_string_literal: true

require 'matrix'

RSpec.describe Matrix do
	describe '.rows' do
		context 'when extractiong rows' do
		
			it("extract a row") do
				matrix = Matrix.new("1 2\n10 20")
				expect(matrix.rows[0]).to(eq([1, 2]))
			end
			
			it("extract same row again") do
				matrix = Matrix.new("9 7\n8 6")
				expect(matrix.rows[0]).to(eq([9, 7]))
			end
			
			it("extract other row") do
				matrix = Matrix.new("9 8 7\n19 18 17")
				expect(matrix.rows[1]).to(eq([19, 18, 17]))
			end
			
			it("extract other row again") do
				matrix = Matrix.new("1 4 9\n16 25 36")
				expect(matrix.rows[1]).to(eq([16, 25, 36]))
			end
			
		end
	end
	describe '.columns' do
		context 'when extractiong columns' do
		
			it("extract a column") do
				matrix = Matrix.new("1 2 3\n4 5 6\n7 8 9\n 8 7 6")
				expect(matrix.columns[0]).to(eq([1, 4, 7, 8]))
			end
			
			it("extract another column") do
				matrix = Matrix.new("89 1903 3\n18 3 1\n9 4 800")
				expect(matrix.columns[1]).to(eq([1903, 3, 4]))
			end
			
		end
	end
end
