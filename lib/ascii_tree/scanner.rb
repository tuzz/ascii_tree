module AsciiTree
  module Scanner
    class << self
      def scan(string)
        Enumerator.new do |yielder|
          indexed_lines(string).each do |line, y|
            indexed_chars(line).each do |char, x|
              yielder.yield [char, Coordinate.new(x: x, y: y)]
            end
          end
        end
      end

      private

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
