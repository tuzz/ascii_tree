module AsciiTree
  class NodeBuilder

    def self.build(*args)
      new(*args).build
    end

    def initialize(relationships)
      @relationships = relationships
    end

    def build
      build_for(root_word, nil)
    end

    private

    attr_reader :relationships

    def root_word
      relationships.first.parent_word
    end

    def build_for(word, parent)
      node = Node.new(
        id: word.id,
        value: word.value,
        parent: parent,
        children: []
      )

      children_for(word, node).each do |child|
        node.children << child
      end

      node
    end

    def children_for(word, parent)
      child_relationships = relationships.select do |r|
        r.parent_word == word
      end

      child_relationships.map do |r|
        build_for(r.child_word, parent)
      end
    end

  end
end
