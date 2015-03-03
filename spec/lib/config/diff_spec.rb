require 'spec_helper'

describe Jack::Config do
  before(:all) do
    Jack::UI.mute = true
  end

  let(:diff) { Jack::Config::Diff.new(test_options) }

  describe "diff" do
    it "diff do_diff" do
      expect(diff).to receive(:do_diff)
      diff.run
    end

    it "diff diff_command" do
      command = diff.diff_command
      expect(command).to match /diff/
    end
  end
end