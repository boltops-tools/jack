module Jack
  module Util
    def do_cmd(command, options={})
      UI.say "Running: #{command.colorize(:green)}" unless options[:silent]
      return command if options[:noop]
      out = `#{command}`
      UI.say out unless options[:silent]
    end

    def app_name_convention(env_name)
      env_name.split('-')[1] # convention
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