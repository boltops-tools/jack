module Jack
  # Any class that includes this module should define @root as it is used in
  # the settings method.
  module Util
    def do_cmd(command, options={})
      UI.say "Running: #{command.colorize(:green)}"
      return command if options[:noop]
      out = `#{command}`
      UI.say out
    end

    def app_name_convention(env_name)
      pattern = settings.app_name_pattern
      env_name.match(pattern)[1]
    end

    def settings
      # do not like the instance @root variable in this module but better
      # than having to pass settings around
      @settings ||= Settings.new(@root)
    end

    def eb
      region = ENV['AWS_REGION'] || 'us-east-1'
      @@eb ||= Aws::ElasticBeanstalk::Client.new(region: region)
    end

    def ensure_folder_exist(folder)
      FileUtils.mkdir_p(folder) unless File.exist?(folder)
    end
  end
end
