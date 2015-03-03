ENV['TEST'] = '1'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "pp"
 
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
end

RSpec.configure do |c|
  c.include Helpers
  c.before :all do
    @root = "spec/fixtures/project"
  end
end