require 'spec_helper'

describe Jack::Config::Upload do
  before(:all) do
    Jack::UI.mute = true
  end

  let(:upload) { Jack::Config::Upload.new(test_options.merge(silent: true)) }

  describe "upload" do
    it "upload code paths" do
      exist = upload.local_cfg_exist?
      expect(exist).to be true # checking fixture
      # mock methods way down deep to test code paths, test reads weird though
      expect(upload).to receive(:eb_config_put)
      upload.upload
    end

    it "upload flow" do
      expect(upload).to receive(:compare)
      expect(upload).to receive(:upload)
      expect(upload).to receive(:update_env)
      upload.run
    end
  end
end