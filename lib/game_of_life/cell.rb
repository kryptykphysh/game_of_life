module GameOfLife
  class Cell
    attr_reader :position
    attr_accessor :neighbours, :state

    def initialize(state: :dead,position: { x: 0, y:0 }, neighbours: [])
      @state = state
      @position = position
      @neighbours = neighbours
    end

    def live!
      @state = :alive
    end

    def die!
      @state = :dead
    end

    def alive?
      @state == :alive
    end

    def dead?
      !alive?
    end
  end
end