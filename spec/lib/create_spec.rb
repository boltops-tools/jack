require 'spec_helper'

describe Jack::Create do
  before(:all) do
    @create = Jack::Create.new(test_options)
  end

  def solution_stacks
    ["64bit Amazon Linux 2014.09 v1.2.0 running Docker 1.3.3", "64bit Amazon Linux 2014.03 v1.0.0 running Docker 1.0.0", "64bit Amazon Linux 2014.03 v1.0.1 running Docker 1.0.0", "64bit Amazon Linux 2014.03 v1.0.4 running Docker 0.9.0", "64bit Amazon Linux 2014.03 v1.0.5 running Docker 0.9.0", "64bit Debian jessie v1.2.0 running Go 1.3 (Preconfigured - Docker)", "64bit Debian jessie v1.2.0 running Go 1.4 (Preconfigured - Docker)"]
  end

  describe "jack" do
    it "create environment" do
      command = @create.build_command
      # puts "command  = #{command }"
      expect(command).to include('eb create')
      expect(command).to include('--cname stag-rails-app-s9')
      expect(command).to include('--platform "64bit Amazon Linux 2014.09 v1.2.0 running Docker 1.3.3"')
      expect(command).to include('--keyname "default"')
      expect(command).to include('--cfg stag-rails-app')
      expect(command).to include('stag-rails-app-s9')
    end

    it "create_yaml" do
      data = @create.create_yaml
      expect(data["keyname"]).to eq "default"
    end

    it "list solution stacks" do
      expect(@create).to receive(:solution_stacks).and_return(solution_stacks)
      expect(@create.latest_docker_platform).to eq "64bit Amazon Linux 2014.09 v1.2.0 running Docker 1.3.3"
    end
  end
end