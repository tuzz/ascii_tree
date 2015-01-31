module AsciiTree
  module WordParser
    class << self

      def parse(string)
        chars = word_chars_with_coordinates(string)
        group_contiguous(chars).map do |word_with_coords|
          Word.new(
            id: id(word_with_coords),
            start_coordinate: word_with_coords.first.last,
            end_coordinate: word_with_coords.last.last
          )
        end
      end

      private

      def word_chars_with_coordinates(string)
        toggle = ParenthesisToggle.new

        Scanner.scan(string).reject do |char, coordinate|
          toggle.read(char)
          toggle.off? && (edge?(char) || whitespace?(char))
        end
      end

      def edge?(char)
        ["/", "|", "\\"].include?(char)
      end

      def whitespace?(char)
        char.match(/\s/)
      end

      def id(word_with_coords)
        word_with_coords.map(&:first).join.gsub(/[\(\)]/, "")
      end

      def group_contiguous(chars)
        chars.inject([]) do |array, (char, coord)|
          prev = previous_coordinate(array)

          if contigous?(prev, coord)
            array.last << [char, coord]
          else
            array << [[char, coord]]
          end

          array
        end
      end

      def previous_coordinate(array)
        previous_array = array.last
        previous_tuple = previous_array.last if previous_array
        previous_tuple.last if previous_tuple
      end

      def contigous?(previous_coordinate, coordinate)
        previous_coordinate &&
          previous_coordinate.y == coordinate.y &&
          previous_coordinate.x == coordinate.x - 1
      end

    end
  end
end
