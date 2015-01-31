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

        validate_one_parent(relationships)
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

      def validate_one_parent(relationships)
        multiple_parents = relationships.select do |relationship|
          count = relationships.count do |r|
            r.child_word == relationship.child_word
          end

          count > 1
        end

        groups = multiple_parents.group_by { |r| r.child_word }

        maps = groups.map do |child_word, relationships|
          parent_words = relationships.map(&:parent_word)
          [child_word.id, parent_words.map(&:id)]
        end

        if maps.any?
          error = ""

          maps.each do |child_word, parent_words|
            parents = parent_words.join("' and '")
            error += "'#{child_word}' has more than one parent: '#{parents}'.\n"
          end
        end

        raise ::AsciiTree::RelationshipError, error if error
      end

      class ::AsciiTree::RelationshipError < StandardError; end
    end
  end
end