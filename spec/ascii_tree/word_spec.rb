require "spec_helper"

module AsciiTree
  describe Word do
    subject do
      described_class.new(
        identity: "foo",
        value: 123,
        start_coordinate: Coordinate.new(x: 3, y: 50),
        end_coordinate: Coordinate.new(x: 5, y: 50),
      )
    end

    describe "#include?" do
      it "returns true if the coordinate is inside the word" do
        expect(subject).to include(Coordinate.new(x: 3, y: 50))
        expect(subject).to include(Coordinate.new(x: 4, y: 50))
        expect(subject).to include(Coordinate.new(x: 5, y: 50))
      end

      it "returns false otherwise" do
        expect(subject).to_not include(Coordinate.new(x: 0, y: 99))
        expect(subject).to_not include(Coordinate.new(x: 2, y: 50))
        expect(subject).to_not include(Coordinate.new(x: 6, y: 50))
        expect(subject).to_not include(Coordinate.new(x: 3, y: 49))
        expect(subject).to_not include(Coordinate.new(x: 3, y: 51))
      end
    end

  end
end
