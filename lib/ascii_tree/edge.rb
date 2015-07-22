module AsciiTree
  class Edge
    attr_reader :character, :coordinate, :parent_coordinate, :child_coordinate

    def initialize(character:, coordinate:, parent_coordinate:, child_coordinate:)
      @character         = character
      @coordinate        = coordinate
      @parent_coordinate = parent_coordinate
      @child_coordinate  = child_coordinate
    end

    def ==(other)
      character == other.character &&
        coordinate == other.coordinate &&
        parent_coordinate == other.parent_coordinate &&
        child_coordinate == other.child_coordinate
    end
  end
end
