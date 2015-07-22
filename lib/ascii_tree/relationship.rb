module AsciiTree
  class Relationship
    attr_reader :parent_word, :edge, :child_word

    def initialize(parent_word:, edge:, child_word:)
      @parent_word = parent_word
      @edge        = edge
      @child_word  = child_word
    end

    def ==(other)
      parent_word == other.parent_word &&
        edge == other.edge &&
        child_word == other.child_word
    end
  end
end
