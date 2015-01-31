require "spec_helper"

module AsciiTree
  describe CommentStripper do

    it "strips comments" do
      string = '
          # comment
                root  # comment
                /  \
               a    b  # / \ | comment
      '

      described_class.strip!(string)

      expect(string).to eq('
                root
                /  \
               a    b
      ')
    end

  end
end
