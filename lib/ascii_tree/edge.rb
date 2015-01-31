class AsciiTree::Edge

  attr_reader :parent_coordinate, :child_coordinate

  def initialize(parent_coordinate:, child_coordinate:)
    @parent_coordinate = parent_coordinate
    @child_coordinate  = child_coordinate
  end

  def ==(other)
    parent_coordinate == other.parent_coordinate &&
      child_coordinate == other.child_coordinate
  end

end
