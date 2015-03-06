require 'spec_helper'

describe Jack::CreateYaml do
  before(:all) do
    Jack::UI.mute = true
  end

  let(:create_yaml) { 
    Jack::CreateYaml.new
  }

  describe "create" do
    it "flags" do
      expect(create_yaml.flags).to eq('--keyname "default"')
    end
  end
end