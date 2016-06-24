require 'spec_helper'

describe Jack::Create do
  before(:all) do
    Jack::UI.mute = true
    @create = Jack::Create.new(test_options)
  end

  describe "jack" do
    it "create environment" do
      command = @create.build_command
      # puts "command  = #{command }"
      expect(command).to include('eb create')
      expect(command).to include('--cname stag-rails-app-s9')
      expect(command).to include('--keyname "default"')
      expect(command).to include('--cfg stag-rails-app')
      expect(command).to include('stag-rails-app-s9')
    end
  end
end
