module AsciiTree
  module RelationshipsBuilder
    class << self

      def build(words, edges)
        relationships = edges.map do |edge|
          parent = words.detect { |w| w.include?(edge.parent_coordinate) }
          child  = words.detect { |w| w.include?(edge.child_coordinate) }

          validate_presence(parent, child, edge)

          Relationship.new(parent_word: parent, edge: edge, child_word: child)
        end

        relationships
      end

      private

      def validate_presence(parent, child, edge)
        if parent.nil? && child.nil?
          error = "No parent or child"
        elsif parent.nil?
          error = "No parent for child '#{child.id}'"
        elsif child.nil?
          error = "No child for parent '#{parent.id}'"
        end

        if error
          c = edge.coordinate
          error += " for edge '#{edge.character}' at line #{c.y}, column #{c.x}"
          raise ::AsciiTree::RelationshipError, error
        end
      end

      class ::AsciiTree::RelationshipError < StandardError; end
    end
  end
end
