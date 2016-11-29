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
      expect(command).to include('--cname hi-web-stag-1')
      expect(command).to include('--keyname "default"')
      expect(command).to include('--cfg hi-web-stag-1')
      expect(command).to include('hi-web-stag-1')
    end
  end
end
