require 'spec_helper'

describe Jack::Config::Apply do
  before(:all) do
    Jack::UI.mute = true
  end

  let(:apply) { Jack::Config::Apply.new(test_options.merge(mute: true)) }

  describe "jack config" do
    it "apply code paths" do
      exist = apply.local_cfg_exist?
      expect(exist).to be true # checking fixture
      # mock methods way down deep to test code paths, test reads weird though
      expect(apply).to receive(:eb_config_put)
      apply.upload
    end

    it "upload flow" do
      allow(apply).to receive(:compare).and_return(true)

      expect(apply).to receive(:compare)
      expect(apply).to receive(:upload)
      expect(apply).to receive(:update_env)
      apply.run
    end
  end
end
