require 'spec_helper'

describe Jack::EbConfig do
  before(:all) do
    Jack::UI.mute = true
  end

  def mock
    {environments: [OpenStruct.new(
      application_name: "myapp", 
      solution_stack_name: "my solution stack")]}
  end

  let(:update) { 
    Jack::EbConfig::Update.new(test_options)
  }

  describe "update" do
    it "sync config" do
      expect(update).to receive(:describe_environments).and_return(mock)
      update.sync

      data = YAML.load_file(update.eb_config_path)
      global = data['global']
      expect(global['application_name']).to eq "myapp"
      expect(global['default_platform']).to eq "my solution stack"
    end

  end
end

