require 'spec_helper'

describe Jack::Config do
  before(:all) do
    Jack::UI.mute = true
  end

  let(:transmit) { Jack::Config::Transmit.new(test_options) }

  describe "transmit" do
    it "config_name_convention" do
      name = transmit.config_name_convention("stag-rails-app-s9")
      expect(name).to eq "stag-rails-app"
    end

    it "timestamp" do
      timestamp = transmit.timestamp
      expect(timestamp).to be_a(String)
    end

    it "extract_name" do
      name = transmit.extract_name("/app/.elasticbeanstalk/saved_cofnigs/stag-rails-app.cfg.yml")
      expect(name).to eq "stag-rails-app"
    end
  end
end