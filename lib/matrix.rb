# comment
class Matrix
  attr_reader :rows, :columns
  def initialize(matrix)
    @rows = matrix.split("\n").map { |a| a.split(' ').map(&:to_i) }
    @columns = @rows.transpose
  end
end
