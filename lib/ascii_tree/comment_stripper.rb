module AsciiTree
  module CommentStripper
    def self.strip(string)
      string.gsub(/#[^\n]*/, "").gsub(/\s+\n/, "\n")
    end
  end
end
