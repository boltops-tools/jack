ENV['TEST'] = '1'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "pp"
require 'ostruct'
 
root = File.expand_path('../../', __FILE__)
require "#{root}/lib/jack"

module Helpers
  def execute(cmd)
    puts "Running: #{cmd}" if ENV['DEBUG']
    out = `#{cmd}`
    puts out if ENV['DEBUG']
    out
  end

  def test_options
    {
      noop: true,
      mute: true,
      force: true,
      root: @root,
      env_name: "stag-rails-app-s9"
    }
  end

  def fake_eb_config
      data = <<-EOL
--- 
global:
  application_name: blah
  default_platform: 64bit Amazon Linux 2014.09 v1.2.0 running Docker 1.3.3
EOL
      path = "#{@root}/.elasticbeanstalk/config.yml"
      File.write(path, data) unless File.exist?(path)
  end

end

RSpec.configure do |c|
  c.include Helpers
  c.before :all do
    @root = "spec/fixtures/project"
  end
end