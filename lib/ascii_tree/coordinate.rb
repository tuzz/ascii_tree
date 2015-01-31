class AsciiTree::Coordinate

  attr_reader :x, :y

  def initialize(x:, y:)
    @x, @y = x, y
  end

  def ==(other)
    x == other.x && y == other.y
  end

end
