require 'spec_helper'

describe Jack::Config do
  before(:all) do
    Jack::UI.mute = true
  end

  let(:download) { Jack::Config::Download.new(test_options) }

  describe "download" do
    it "download" do
      # mock methods way down deep to test code paths, test reads weird though
      expect(download).to receive(:eb_config_save)
      expect(download).to receive(:do_copy_to_local_cfg)
      download.download
    end

    # it "should add jack/cfg/*.yml to gitignore" do
    #   download.download
    #   ignore = IO.read("#{@root}/.gitignore")
    #   expect(ignore).to include("jack/cfg")
    # end

  end
end