require 'spec_helper'

describe Jack::VersionChecker do
  let(:checker) { Jack::VersionChecker.new }

  describe "version checker" do
    it "should exit if version is less than required version" do
      expect(checker).to receive(:get_version).and_return("EB CLI 3.0.0 (Python 2.7.6)")
      expect(checker).to receive(:leave).at_least(:once)
      checker.run
    end

    it "should not exit if version matches required version" do
      expect(checker).to receive(:get_version).and_return("EB CLI 3.1.2 (Python 2.7.6)")
      allow(checker).to receive(:leave).and_return(true) # need to stub in order to use to_nav have_received
      expect(checker).to_not have_received(:leave)
      checker.run
    end

    it "should not exit if version is great than required version" do
      expect(checker).to receive(:get_version).and_return("EB CLI 3.2.0 (Python 2.7.6)")
      allow(checker).to receive(:leave).and_return(true) # need to stub in order to use to_nav have_received
      expect(checker).to_not have_received(:leave)
      checker.run
    end

    it "parse version" do
      version = checker.parse_version("EB CLI 3.2.0 (Python 2.7.6)")
      expect(version).to eq "3.2.0"
    end
  end
end
