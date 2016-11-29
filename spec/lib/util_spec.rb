require 'spec_helper'

# just for the spec
class Utilable
  include Jack::Util
  def initialize(root)
    @root = root
  end
end

describe Jack::Util do
  before(:all) do
    Jack::UI.mute = true
  end
  let(:util) do
    Utilable.new(@root)
  end

  describe "util" do
    it "app_name_convention default" do
      app_name = util.app_name_convention("rails-web-prod-1")
      expect(app_name).to eq "rails"
    end

    context "custom app_name_convention" do
      before(:each) { fake_project.create_settings }
      after(:each)  { fake_project.remove_settings }
      it "app_name_convention from project settings.yml" do
        app_name = util.app_name_convention("rails-web-prod1")
        expect(app_name).to eq "rails"
      end
    end
  end
end
