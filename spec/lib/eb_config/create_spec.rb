require 'spec_helper'

describe Jack::EbConfig do
  before(:all) do
    Jack::UI.mute = true
  end

  def solution_stacks
    [
      "64bit Amazon Linux 2015.03 v1.4.6 running Docker 1.6.2",
      "64bit Amazon Linux 2015.09 v2.0.6 running Docker 1.7.1",
      "64bit Amazon Linux 2016.03 v2.1.0 running Docker 1.9.1",
      "64bit Debian jessie v2.1.0 running GlassFish 4.1 Java 8 (Preconfigured - Docker)",
      "64bit Amazon Linux 2015.03 v1.4.6 running Multi-container Docker 1.6.2 (Generic)"
    ]
  end

  let(:create) do
    Jack::EbConfig::Create.new(test_options(env_name))
  end
  let(:env_name) { "stag-rails-app-s9" }

  describe "Create#sync" do
    context "default platform from default settings" do
      it "have default platform from default settings" do
        create.sync

        data = YAML.load_file(create.eb_config_path)
        global = data['global']
        expect(global['application_name']).to eq "rails"
        expect(global['default_platform']).to eq "64bit Amazon Linux 2015.03 v1.4.0 running Docker 1.6.0"
      end
    end

    context "different platform from project settings" do
      let(:env_name) { "rails-app-stag9" }

      before(:each) { fake_project.create_settings }
      after(:each)  { fake_project.remove_settings }
      it "have platform from project settings" do
        create.sync

        data = YAML.load_file(create.eb_config_path)
        global = data['global']
        expect(global['application_name']).to eq "rails"
        expect(global['default_platform']).to eq "Fake Platform From Project Settings"
      end
    end

    # To see newest solution stacks:
    # aws elasticbeanstalk list-available-solution-stacks  | jq '.SolutionStacks' | grep Docker
    it "list solution stacks" do
      expect(create).to receive(:solution_stacks).and_return(solution_stacks)
      expect(create.latest_docker_platform).to eq "64bit Amazon Linux 2016.03 v2.1.0 running Docker 1.9.1"
    end
  end
end
