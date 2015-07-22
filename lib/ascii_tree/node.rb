module AsciiTree
  class Node

    attr_reader :identity, :value, :parent, :children

    def initialize(identity:, value:, parent:, children:)
      @identity = identity
      @value    = value
      @parent   = parent
      @children = children
    end

    def ==(other)
      identity == other.identity &&
        value == other.value &&
        parent == other.parent &&
        children == other.children
    end

  end
end
