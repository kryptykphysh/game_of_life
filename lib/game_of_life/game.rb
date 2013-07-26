module GameOfLife
  class Game
    attr_reader :world, :cells

    def initialize(world=World.new)
      @world = world
      @cells = @world.cells
    end

    def spawn_life
      @cells.sample(Random.new.rand(@cells.size)).each do |cell|
        cell.live!
      end
    end

    def evolve!
      to_change_state = { to_die: [], to_live: [] }
      cells.each do |cell|
        if cell.alive? && !(2..3).include?(number_of_living_neighbours(cell))
          to_change_state[:to_die] << cell
        elsif cell.dead? && number_of_living_neighbours(cell) == 3
          to_change_state[:to_live] << cell
        end
      end
      to_change_state[:to_die].each { |cell| cell.die! }
      to_change_state[:to_live].each { |cell| cell.live! }
    end

    private

      def number_of_living_neighbours(cell)
        neighbourhood = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
        number_of_living_neighbours = cell.neighbours.count do |coords|
          #cells.find { |c| c.position == coords }.alive?
          self.world.grid[coords[:x]][coords[:y]].alive?
        end
      end
  end
end