module AsciiTree
  class Word

    attr_reader :id, :start_coordinate, :end_coordinate

    def initialize(id:, start_coordinate:, end_coordinate:)
      @id               = id
      @start_coordinate = start_coordinate
      @end_coordinate   = end_coordinate
    end

    def ==(other)
      id == other.id &&
        start_coordinate == other.start_coordinate &&
        end_coordinate == other.end_coordinate
    end

    def include?(coordinate)
      same_line?(coordinate.y) && inside?(coordinate.x)
    end

    private

    def same_line?(y)
      y == start_coordinate.y && y == end_coordinate.y
    end

    def inside?(x)
      (start_coordinate.x..end_coordinate.x).include?(x)
    end

  end
end