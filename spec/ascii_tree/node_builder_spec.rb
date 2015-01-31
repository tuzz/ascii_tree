require "spec_helper"

module AsciiTree
  describe NodeBuilder do
    let(:coordinate) { Coordinate.new(x: 0, y: 0) }

    let(:relationships) do
      [
        Relationship.new(
          parent_word: Word.new(
            id: "root",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          ),
          edge: double(:edge),
          child_word: Word.new(
            id: "a",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          )
        ),
        Relationship.new(
          parent_word: Word.new(
            id: "root",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          ),
          edge: double(:edge),
          child_word: Word.new(
            id: "b",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          )
        ),
        Relationship.new(
          parent_word: Word.new(
            id: "a",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          ),
          edge: double(:edge),
          child_word: Word.new(
            id: "c",
            start_coordinate: coordinate,
            end_coordinate: coordinate,
          )
        ),
      ]
    end

    it "builds a root node from a relationships array" do
      root = described_class.build(relationships)
      expect(root.id).to eq("root")
      expect(root.value).to eq(nil)
      expect(root.children.size).to eq(2)
      a, b = root.children

      expect(a.id).to eq("a")
      expect(b.id).to eq("b")
      expect(a.value).to eq(nil)
      expect(b.value).to eq(nil)
      expect(a.children.size).to eq(1)
      expect(b.children.size).to eq(0)

      c = a.children.first
      expect(c.id).to eq("c")
      expect(c.value).to eq(nil)
      expect(c.children.size).to eq(0)
    end

    pending "add support for values"
  end
end
