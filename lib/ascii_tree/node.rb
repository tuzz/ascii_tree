module AsciiTree
  class Node

    attr_reader :id, :value, :parent, :children

    def initialize(id:, value:, parent:, children:)
      @id       = id
      @value    = value
      @parent   = parent
      @children = children
    end

    def ==(other)
      id == other.id &&
        value == other.value &&
        parent == other.parent &&
        children == other.children
    end

  end
end
