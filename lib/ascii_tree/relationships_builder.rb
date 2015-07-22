module AsciiTree
  module RelationshipsBuilder
    class << self
      def build(words, edges)
        relationships = []

        root_relationship = root_relationship(words)
        relationships << root_relationship if root_relationship

        relationships += edges.map do |edge|
          parent = words.detect { |w| w.include?(edge.parent_coordinate) }
          child  = words.detect { |w| w.include?(edge.child_coordinate) }

          validate_presence(parent, child, edge)

          Relationship.new(parent_word: parent, edge: edge, child_word: child)
        end

        validate_one_parent(relationships)
        relationships
      end

      private

      def root_relationship(words)
        return unless words.any?

        root_word = words.first
        Relationship.new(parent_word: nil, edge: nil, child_word: root_word)
      end

      def validate_presence(parent, child, edge)
        if parent.nil? && child.nil?
          error = "No parent or child"
        elsif parent.nil?
          error = "No parent for child '#{child.identity}'"
        elsif child.nil?
          error = "No child for parent '#{parent.identity}'"
        end

        return unless error

        c = edge.coordinate
        error += " for edge '#{edge.character}' at line #{c.y}, column #{c.x}"
        fail ::AsciiTree::RelationshipError, error
      end

      def validate_one_parent(relationships)
        multiple_parents = relationships.select do |relationship|
          count = relationships.count do |r|
            r.child_word == relationship.child_word
          end

          count > 1
        end

        groups = multiple_parents.group_by(&:child_word)

        maps = groups.map do |child_word, rels|
          parent_words = rels.map(&:parent_word)
          [child_word.identity, parent_words.map(&:identity)]
        end

        if maps.any?
          error = ""

          maps.each do |child_word, parent_words|
            parents = parent_words.join("' and '")
            error += "'#{child_word}' has more than one parent: '#{parents}'.\n"
          end
        end

        fail ::AsciiTree::RelationshipError, error if error
      end
    end
  end

  class RelationshipError < StandardError; end
end
