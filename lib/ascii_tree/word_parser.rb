module AsciiTree
  module WordParser
    class << self

      def parse(string)
        chars = word_chars_with_coordinates(string)
        group_contiguous(chars).map do |word|
          Word.new(
            id: word.map(&:first).join,
            start_coordinate: word.first.last,
            end_coordinate: word.last.last
          )
        end
      end

      private

      def word_chars_with_coordinates(string)
        Scanner.scan(string).reject do |char, _|
          ["/", "|", "\\"].include?(char) || char.match(/\s/)
        end
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
