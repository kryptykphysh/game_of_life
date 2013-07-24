module GameOfLife
  class World
    attr_reader :rows, :columns, :grid

    def initialize(rows=10, columns=10)
      @rows, @columns = rows, columns
      @grid = Array.new(rows) { Array.new(columns) { Cell.new } }
    end
  end
end