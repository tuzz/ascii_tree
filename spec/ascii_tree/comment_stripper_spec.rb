require "spec_helper"

module AsciiTree
  RSpec.describe CommentStripper do

    it "strips comments" do
      result = described_class.strip('
          # comment
                root  # comment
                /  \
               a    b  # / \ | comment
      ')

      expect(result).to eq('
                root
                /  \
               a    b
      ')
    end

    it "does not mutate its input" do
      string = "#comment"
      described_class.strip(string)
      expect(string).to eq("#comment")
    end

  end
end
