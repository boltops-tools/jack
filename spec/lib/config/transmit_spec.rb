require 'spec_helper'
require 'ostruct'

describe Jack::Config do
  before(:all) do
    Jack::UI.mute = true
    fake_eb_config
  end

  let(:transmit) { Jack::Config::Transmit.new(test_options) }

  def fake_eb_config
      input = <<-EOL
--- 
global:
  application_name: blah
  default_platform: 64bit Amazon Linux 2014.09 v1.2.0 running Docker 1.3.3
EOL
      file = "#{@root}/.elasticbeanstalk/config.yml"
      File.open(file, 'w') { |file| file.write(input) }
  end

  def mock
    {environments: [OpenStruct.new(
      application_name: "myapp", 
      solution_stack_name: "my solution stack")]}
  end

  describe "transmit" do
    it "sync_eb_config_yml" do
      expect(transmit).to receive(:describe_environments).and_return(mock)
      transmit.sync_eb_config_yml(true)

      data = YAML.load_file(transmit.eb_config_path)
      global = data['global']
      expect(global['application_name']).to eq "myapp"
      expect(global['default_platform']).to eq "my solution stack"
    end

  end
end