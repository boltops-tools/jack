require 'spec_helper'

describe Jack::EbConfig do
  before(:all) do
    Jack::UI.mute = true
    fake_eb_config
  end

  def solution_stacks
    ["64bit Amazon Linux 2014.09 v1.2.0 running Docker 1.3.3", "64bit Amazon Linux 2014.03 v1.0.0 running Docker 1.0.0", "64bit Amazon Linux 2014.03 v1.0.1 running Docker 1.0.0", "64bit Amazon Linux 2014.03 v1.0.4 running Docker 0.9.0", "64bit Amazon Linux 2014.03 v1.0.5 running Docker 0.9.0", "64bit Debian jessie v1.2.0 running Go 1.3 (Preconfigured - Docker)", "64bit Debian jessie v1.2.0 running Go 1.4 (Preconfigured - Docker)"]
  end

  let(:create) { 
    Jack::EbConfig::Create.new(test_options)
  }

  describe "create" do
    it "sync config" do
      expect(create).to receive(:solution_stacks).and_return(solution_stacks)
      create.sync

      data = YAML.load_file(create.eb_config_path)
      global = data['global']
      expect(global['application_name']).to eq "rails"
      expect(global['default_platform']).to eq "64bit Amazon Linux 2014.09 v1.2.0 running Docker 1.3.3"
    end

    it "list solution stacks" do
      expect(create).to receive(:solution_stacks).and_return(solution_stacks)
      expect(create.latest_docker_platform).to eq "64bit Amazon Linux 2014.09 v1.2.0 running Docker 1.3.3"
    end
  end
end