module GameOfLife
  class World
    attr_reader :rows, :columns, :grid, :cells

    def initialize(rows=10, columns=10)
      @rows, @columns = rows, columns
      @grid = create_grid
      @cells = grid.flatten
      set_neighbours_on_cells!
    end

    private

      def create_grid
        new_grid = Array.new(rows) { Array.new(columns) }
        add_cells_to_grid(new_grid)
        new_grid
      end

      def add_cells_to_grid(grid)
        grid.each_with_index do |row, row_number|
          row.each_with_index do |element, column_number|
            grid[row_number][column_number] = Cell.new( 
              position: { x: row_number, y: column_number }
            )
          end
        end
      end

      def set_neighbours_on_cells!
        neighbour_offset = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
        cells.each do |cell|
          surrounding_locations = neighbour_offset.map { |e| {x: e[1] + cell.position[:x], y: e[0] + cell.position[:y]} }
          cell.neighbours = surrounding_locations.select do |ref|
            ref[:x] >= 0 && ref[:y] >=0 && ref[:x] < @rows && ref[:y] < @columns
          end
        end
      end        
  end
end