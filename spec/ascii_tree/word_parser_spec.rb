require "spec_helper"

module AsciiTree
  describe WordParser do

    it "parses words" do
      words = described_class.parse('
          foo bar baz
      ')

      expect(words).to eq [
        Word.new(
          id: "foo",
          start_coordinate: Coordinate.new(x: 10, y: 1),
          end_coordinate: Coordinate.new(x: 12, y: 1)
        ),
        Word.new(
          id: "bar",
          start_coordinate: Coordinate.new(x: 14, y: 1),
          end_coordinate: Coordinate.new(x: 16, y: 1)
        ),
        Word.new(
          id: "baz",
          start_coordinate: Coordinate.new(x: 18, y: 1),
          end_coordinate: Coordinate.new(x: 20, y: 1)
        )
      ]
    end

    it "respects parenthesis" do
      words = described_class.parse('
          (foo bar) baz
      ')

      expect(words).to eq [
        Word.new(
          id: "foo bar",
          start_coordinate: Coordinate.new(x: 10, y: 1),
          end_coordinate: Coordinate.new(x: 18, y: 1)
        ),
        Word.new(
          id: "baz",
          start_coordinate: Coordinate.new(x: 20, y: 1),
          end_coordinate: Coordinate.new(x: 22, y: 1)
        )
      ]
    end

  end
end
