module AsciiTree
  module EdgeParser
    class << self

      def parse(string)
        edge_chars_with_coordinates(string).map do |char, coordinate|
          offsets = edge_offsets[char]

          Edge.new(
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
        chars_with_coordinates(string).select do |char, _|
          edge_offsets.keys.include?(char)
        end
      end

      def chars_with_coordinates(string)
        chars = []

        indexed_lines(string).each do |line, y|
          indexed_chars(line).each do |char, x|
            chars << [char, Coordinate.new(x: x, y: y)]
          end
        end

        chars
      end

      def indexed_lines(string)
        lines(string).each.with_index.to_a
      end

      def lines(string)
        string.split("\n")
      end

      def indexed_chars(line)
        chars(line).each_with_index.to_a
      end

      def chars(line)
        line.split("")
      end

    end
  end
end
