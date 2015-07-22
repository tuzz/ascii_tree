require "spec_helper"

module AsciiTree
  RSpec.describe RelationshipsBuilder do
    let(:parent) do
      Word.new(
        identity: "parent",
        value: nil,
        start_coordinate: Coordinate.new(x: 0, y: 0),
        end_coordinate: Coordinate.new(x: 5, y: 0)
      )
    end

    let(:child) do
      Word.new(
        identity: "child",
        value: nil,
        start_coordinate: Coordinate.new(x: 0, y: 2),
        end_coordinate: Coordinate.new(x: 5, y: 2)
      )
    end

    let(:edge) do
      Edge.new(
        character: "|",
        coordinate: Coordinate.new(x: 3, y: 1),
        parent_coordinate: Coordinate.new(x: 3, y: 0),
        child_coordinate: Coordinate.new(x: 3, y: 2)
      )
    end

    it "builds relationships from words and edges" do
      words = [parent, child]
      edges = [edge]

      relationships = described_class.build(words, edges)

      expect(relationships).to eq [
        Relationship.new(
          parent_word: nil,
          edge: nil,
          child_word: parent
        ),
        Relationship.new(
          parent_word: parent,
          edge: edge,
          child_word: child
        )
      ]
    end

    it "returns an empty array when there are no words" do
      words = []
      edges = []

      relationships = described_class.build(words, edges)
      expect(relationships).to be_empty
    end

    describe "error cases" do
      it "raises an error if there is neither a parent or child" do
        words = []
        edges = [edge]

        expect {
          described_class.build(words, edges)
        }.to raise_error(/no parent or child/i)
      end

      it "raises an error if there is no parent" do
        words = [child]
        edges = [edge]

        expect {
          described_class.build(words, edges)
        }.to raise_error(/no parent/i)
      end

      it "raises an error if there is no child" do
        words = [parent]
        edges = [edge]

        expect {
          described_class.build(words, edges)
        }.to raise_error(/no child/i)
      end

      it "raises an error if a child has more than one parent" do
        another_parent = Word.new(
          identity: "another parent",
          value: nil,
          start_coordinate: Coordinate.new(x: 6, y: 0),
          end_coordinate: Coordinate.new(x: 9, y: 0)
        )

        another_edge = Edge.new(
          character: "/",
          coordinate: Coordinate.new(x: 5, y: 1),
          parent_coordinate: Coordinate.new(x: 6, y: 0),
          child_coordinate: Coordinate.new(x: 4, y: 2)
        )

        words = [parent, child, another_parent]
        edges = [edge, another_edge]

        expect {
          described_class.build(words, edges)
        }.to raise_error(/more than one parent/)
      end
    end

  end
end
