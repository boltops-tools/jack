require 'spec_helper'

describe Jack::CLI do
  before(:all) do
    @args = "hi-web-stag-1 --root spec/fixtures/project --noop --force"
    FileUtils.rm_rf("spec/fixtures/project/.elasticbeanstalk")
  end

  describe "jack" do
    it "should create environment" do
      out = execute("bin/jack create #{@args}")
      # puts out
      expect(out).to include('eb create')
      expect(out).to include('--cname hi-web-stag-1')
      expect(out).to include('--keyname "default"')
      expect(out).to include('hi-web-stag-1')
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
