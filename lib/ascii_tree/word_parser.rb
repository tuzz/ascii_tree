module AsciiTree
  module WordParser
    class << self
      def parse(string)
        chars = word_chars_with_coordinates(string)
        group_contiguous(chars).map do |word_with_coords|
          identity, value = identity_value(word_with_coords)

          Word.new(
            identity: identity.strip,
            value: value,
            start_coordinate: word_with_coords.first.last,
            end_coordinate: word_with_coords.last.last
          )
        end
      end

      private

      def word_chars_with_coordinates(string)
        toggle = ParenthesisToggle.new

        Scanner.scan(string).reject do |char, _coordinate|
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

      def identity_value(word_with_coords)
        chars = word_with_coords.map(&:first)
        chars = remove_parentheses(chars)

        word = chars.join
        word.strip!

        if word.end_with?("}")
          identity, tail = word.split("{", 2)
          expression = tail[0..-2]
          value = eval(expression)
          [identity, value]
        else
          [word, nil]
        end
      end

      def remove_parentheses(chars)
        if chars.first == "(" && chars.last == ")"
          chars[1..-2]
        else
          chars
        end
      end

      def group_contiguous(chars)
        chars.each_with_object([]) do |(char, coord), array|
          prev = previous_coordinate(array)

          if contigous?(prev, coord)
            array.last << [char, coord]
          else
            array << [[char, coord]]
          end
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
