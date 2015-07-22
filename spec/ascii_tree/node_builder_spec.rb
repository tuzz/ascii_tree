require "spec_helper"

module AsciiTree
  describe NodeBuilder do
    let(:coordinate) { Coordinate.new(x: 0, y: 0) }

    let(:relationships) do
      [
        Relationship.new(
          parent_word: nil,
          edge: nil,
          child_word: Word.new(
            identity: "root",
            value: "root value",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          )
        ),
        Relationship.new(
          parent_word: Word.new(
            identity: "root",
            value: "root value",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          ),
          edge: double(:edge),
          child_word: Word.new(
            identity: "a",
            value: "a value",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          )
        ),
        Relationship.new(
          parent_word: Word.new(
            identity: "root",
            value: "root value",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          ),
          edge: double(:edge),
          child_word: Word.new(
            identity: "b",
            value: "b value",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          )
        ),
        Relationship.new(
          parent_word: Word.new(
            identity: "a",
            value: "a value",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          ),
          edge: double(:edge),
          child_word: Word.new(
            identity: "c",
            value: "c value",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          )
        ),
      ]
    end

    it "builds a root node from a relationships array" do
      root = described_class.build(relationships)
      expect(root.identity).to eq("root")
      expect(root.value).to eq("root value")
      expect(root.children.size).to eq(2)
      a, b = root.children

      expect(a.identity).to eq("a")
      expect(b.identity).to eq("b")
      expect(a.value).to eq("a value")
      expect(b.value).to eq("b value")
      expect(a.children.size).to eq(1)
      expect(b.children.size).to eq(0)

      c = a.children.first
      expect(c.identity).to eq("c")
      expect(c.value).to eq("c value")
      expect(c.children.size).to eq(0)
    end

    it "returns nil when given an empty array" do
      result = described_class.build([])
      expect(result).to be_nil
    end

  end
end
