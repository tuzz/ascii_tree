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

  end
end
