require "spec_helper"

module AsciiTree
  RSpec.describe ParenthesisToggle do
    it "is initialized in the 'off' position" do
      expect(subject).to be_off
    end

    describe "#read" do
      it "switches on when it sees an opening parenthesis" do
        subject.read("(")
        expect(subject).to be_on
      end

      it "switches off when it sees a closing parenthesis" do
        subject.read("(")
        subject.read(")")
        expect(subject).to be_off
      end

      it "maintains its state between reads" do
        subject.read("f")
        expect(subject).to be_off

        subject.read("(")
        expect(subject).to be_on

        subject.read("o")
        expect(subject).to be_on

        subject.read("o")
        expect(subject).to be_on

        subject.read(")")
        expect(subject).to be_off

        subject.read("b")
        expect(subject).to be_off

        subject.read("a")
        expect(subject).to be_off

        subject.read("(")
        expect(subject).to be_on

        subject.read("r")
        expect(subject).to be_on

        subject.read(")")
        expect(subject).to be_off
      end
    end

    it "copes with nested parenthesis" do
      subject.read("(")
      subject.read("(")
      subject.read("(")

      subject.read(")")
      expect(subject).to be_on

      subject.read(")")
      expect(subject).to be_on

      subject.read(")")
      expect(subject).to be_off

      subject.read(")")
      subject.read(")")
      subject.read(")")
      subject.read(")")
      expect(subject).to be_off

      subject.read("(")
      expect(subject).to be_on
    end
  end
end
