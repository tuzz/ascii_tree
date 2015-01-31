module AsciiTree
  module EdgeParser
    class << self

      def parse(string)
        edge_chars_with_coordinates(string).map do |char, coordinate|
          offsets = edge_offsets[char]

          Edge.new(
            character: char,
            coordinate: coordinate,
            parent_coordinate: Coordinate.new(
              x: coordinate.x + offsets[:parent][:x],
              y: coordinate.y + offsets[:parent][:y]
            ),
            child_coordinate: Coordinate.new(
              x: coordinate.x + offsets[:child][:x],
              y: coordinate.y + offsets[:child][:y]
            )
          )
        end
      end

      private

      def edge_offsets
        {
          "/"  => { parent: { x: +1, y: -1 }, child: { x: -1, y: +1 } },
          "|"  => { parent: { x:  0, y: -1 }, child: { x:  0, y: +1 } },
          "\\" => { parent: { x: -1, y: -1 }, child: { x: +1, y: +1 } }
        }
      end

      def edge_chars_with_coordinates(string)
        Scanner.scan(string).select do |char, _|
          edge_offsets.keys.include?(char)
        end
      end

    end
  end
end
