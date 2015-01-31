module AsciiTree
  class ParenthesisToggle

    def initialize
      @on, @count = false, 0
    end

    def read(char)
      if char == "("
        @on = true
      elsif char == ")"
        @on = false
      end

      if char == "("
        @count += 1
      elsif char == ")"
        @count -= 1
        @count = 0 if @count < 0
      end

      @on = @count > 0
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
