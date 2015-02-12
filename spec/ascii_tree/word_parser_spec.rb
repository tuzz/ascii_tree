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
          value: nil,
          start_coordinate: Coordinate.new(x: 10, y: 1),
          end_coordinate: Coordinate.new(x: 12, y: 1)
        ),
        Word.new(
          id: "bar",
          value: nil,
          start_coordinate: Coordinate.new(x: 14, y: 1),
          end_coordinate: Coordinate.new(x: 16, y: 1)
        ),
        Word.new(
          id: "baz",
          value: nil,
          start_coordinate: Coordinate.new(x: 18, y: 1),
          end_coordinate: Coordinate.new(x: 20, y: 1)
        )
      ]
    end

    it "respects parenthesis" do
      words = described_class.parse('
          (foo bar) baz (       qux        )
      ')

      expect(words).to eq [
        Word.new(
          id: "foo bar",
          value: nil,
          start_coordinate: Coordinate.new(x: 10, y: 1),
          end_coordinate: Coordinate.new(x: 18, y: 1)
        ),
        Word.new(
          id: "baz",
          value: nil,
          start_coordinate: Coordinate.new(x: 20, y: 1),
          end_coordinate: Coordinate.new(x: 22, y: 1)
        ),
        Word.new(
          id: "qux",
          value: nil,
          start_coordinate: Coordinate.new(x: 24, y: 1),
          end_coordinate: Coordinate.new(x: 43, y: 1)
        )
      ]
    end

    it "supports arbitrary values" do
      words = described_class.parse('
          foo{1} bar{"2"} baz{[1,2].inject(:+)}
      ')

      expect(words).to eq [
        Word.new(
          id: "foo",
          value: 1,
          start_coordinate: Coordinate.new(x: 10, y: 1),
          end_coordinate: Coordinate.new(x: 15, y: 1)
        ),
        Word.new(
          id: "bar",
          value: "2",
          start_coordinate: Coordinate.new(x: 17, y: 1),
          end_coordinate: Coordinate.new(x: 24, y: 1)
        ),
        Word.new(
          id: "baz",
          value: 3,
          start_coordinate: Coordinate.new(x: 26, y: 1),
          end_coordinate: Coordinate.new(x: 46, y: 1)
        )
      ]
    end

    it "works with parentheses and values are combined" do
      words = described_class.parse('
              (     foo{1}      )
      ')

      expect(words).to eq [
        Word.new(
          id: "foo",
          value: 1,
          start_coordinate: Coordinate.new(x: 14, y: 1),
          end_coordinate: Coordinate.new(x: 32, y: 1)
        )
      ]

    end

  end
end
