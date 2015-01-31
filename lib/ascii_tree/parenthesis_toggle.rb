module AsciiTree
  class ParenthesisToggle

    def initialize
      @on = false
    end

    def read(char)
      if char == "("
        @on = true
      elsif char == ")"
        @on = false
      end
    end

    def on?
      @on
    end

    def off?
      !@on
    end

    private

    attr_reader :on

  end
end
