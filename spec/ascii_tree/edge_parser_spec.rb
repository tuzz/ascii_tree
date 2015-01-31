require "spec_helper"

module AsciiTree
  describe EdgeParser do

    it "parses edges" do
      edges = described_class.parse('
          /  |  \
      ')

      expect(edges).to eq [
        Edge.new(
          parent_coordinate: Coordinate.new(x: 11, y: 0),
          child_coordinate: Coordinate.new(x: 9, y: 2)
        ),
        Edge.new(
          parent_coordinate: Coordinate.new(x: 13, y: 0),
          child_coordinate: Coordinate.new(x: 13, y: 2)
        ),
        Edge.new(
          parent_coordinate: Coordinate.new(x: 15, y: 0),
          child_coordinate: Coordinate.new(x: 17, y: 2)
        )
      ]
    end

  end
end
