require 'fileutils'
require 'yaml'

module Jack
  module Config
    class Transmit
      include Util

      attr_reader :local_config_path
      def initialize(options={})
        @options = options
        @root = options[:root] || '.'
        @env_name = options[:env_name]
        @app_name = @options[:app_name] || app_name_convention(@env_name)

        @saved_configs = "#{@root}/.elasticbeanstalk/saved_configs"

        local_config_name = options[:cfg] || config_name_convention(@env_name)
        @local_config_path = "jack/cfg/#{local_config_name}.cfg.yml"

        # should break out to another class but too much work right now
        create = Create.new(options)
        create.ensure_eb_init
      end

    private

      def config_name_convention(env_name)
        env_name.split('-')[0..-2].join('-')
      end

      def timestamp
        Time.now.strftime "%Y-%m-%d_%H-%M-%S"
      end

      def extract_name(path)
        path.split('/').last.sub('.cfg.yml','')
      end
    end
  end
end