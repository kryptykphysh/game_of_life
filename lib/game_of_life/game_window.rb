require 'gosu'

module GameOfLife
  class GameWindow < Gosu::Window
    def initialize(width=600, height=800)
      @height = height
      @width = width
      super height, width, false
      self.caption = "KryptykPhysh's Game of Life"

      # Colour
      @background_colour = Gosu::Color.new(0xffdedede)
      @alive_colour = Gosu::Color.new(0xff121212)
      @dead_colour = Gosu::Color.new(0xffededed)

      # Game environment
      @columns = width / 5
      @rows = height / 5

      @column_width = width/@columns
      @row_height = height/@rows

      @world = World.new(@rows, @columns)
      @game = Game.new(@world)
      @game.spawn_life
    end

    def update
      @game.evolve!
    end

    def draw
      # Background
      draw_quad(0, 0, @background_colour,
                width, 0, @background_colour,
                width, height, @background_colour,
                0, height, @background_colour)

      # Drawing cells
      @game.cells.each do |cell|
        x = cell.position[:x]
        y = cell.position[:y]
        
        cell_colour = cell.alive? ? @alive_colour : @dead_colour
        
        draw_quad(x * @column_width, y * @row_height, cell_colour,
                  x * @column_width + (@column_width - 1), y * @row_height, cell_colour,
                  x * @column_width + (@column_width - 1), y * @row_height + (@row_height - 1), cell_colour,
                  x * @column_width, y * @row_height + (@row_height - 1), cell_colour)
      end

      def needs_cursor?
        true
      end
    end
  end
end