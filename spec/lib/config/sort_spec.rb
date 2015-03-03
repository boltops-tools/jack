require 'spec_helper'

describe Jack::Config do
  before(:all) do
    Jack::UI.mute = true
  end

  let(:sort) { Jack::Config::Sort.new(test_options) }

  describe "sort" do
    it "process" do
      # not much to check just for syntax errors
      sort.run
    end
  end
end