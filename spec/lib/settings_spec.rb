require 'spec_helper'

describe Jack::Settings do
  before(:all) do
    Jack::UI.mute = true
  end
  let(:settings) {
    Jack::Settings.new(@root)
  }

  describe "create" do
    context "custom project settings" do
      before(:each) { fake_project.create_settings }
      after(:each)  { fake_project.remove_settings }
      it "flags uses custom project settings" do
        project_flags = '--keyname "default" --platform "Fake Platform From Project Settings"'
        expect(settings.create_flags).to eq(project_flags)
      end
    end

    context "no custom project settings" do
      it "flags uses defaults provided gem" do
        project_flags = '--keyname "default" --platform "64bit Amazon Linux 2016.09 v2.2.0 running Docker 1.11.2"'
        expect(settings.create_flags).to eq(project_flags)
      end
    end
  end
end
