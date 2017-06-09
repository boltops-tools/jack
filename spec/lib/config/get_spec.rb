require 'spec_helper'

describe Jack::Config do
  before(:all) do
    Jack::UI.mute = true
  end

  let(:get) { Jack::Config::Get.new(test_options) }

  describe "jack config" do
    it "get" do
      # mock methods way down deep to test code paths, test reads weird though
      expect(get).to receive(:eb_config_save)
      expect(get).to receive(:do_copy_to_local_cfg)
      get.download
    end

    # it "should add jack/cfg/*.yml to gitignore" do
    #   download.download
    #   ignore = IO.read("#{@root}/.gitignore")
    #   expect(ignore).to include("jack/cfg")
    # end

  end
end
