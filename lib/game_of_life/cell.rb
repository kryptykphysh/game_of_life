module GameOfLife
  class Cell
    attr_reader :state
    
    def initialize
      @state = :dead
    end
  end
end