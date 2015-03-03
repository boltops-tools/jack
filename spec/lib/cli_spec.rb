require 'spec_helper'

describe Jack::CLI do
  before(:all) do
    @args = "stag-rails-app-s9 --root spec/fixtures/project --noop --force"
    FileUtils.rm_rf("spec/fixtures/project/.elasticbeanstalk")
  end

  describe "jack" do
    it "should create environment" do
      out = execute("bin/jack create #{@args}")
      # puts out
      expect(out).to include('eb create')
      expect(out).to include('--cname stag-rails-app-s9')
      expect(out).to include('--platform "64bit Amazon Linux 2014.09 v1.2.0 running Docker 1.3.3"')
      expect(out).to include('--keyname "default"')
      expect(out).to include('--cfg stag-rails-app')
      expect(out).to include('stag-rails-app-s9')
    end

    it "should upload and apply config to environment" do
      out = execute("bin/jack config upload #{@args}")
      # puts out
      expect(out).to include('eb config put')
    end

    it "should download config from environment" do
      out = execute("bin/jack config download #{@args}")
      # puts out
      expect(out).to include("Config downloaded")
    end

    it "should diff local config from eb environment config" do
      out = execute("bin/jack config diff #{@args}")
      # puts out
      expect(out).to include("Comparing")
    end

    it "should reformat the local config to a sorted yaml format" do
      out = execute("bin/jack config sort #{@args}")
      # puts out
      expect(out).to include("Reformatted the local config")
    end
  end
end