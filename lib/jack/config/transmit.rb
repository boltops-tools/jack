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
      end

      def eb_config_path
        "#{@root}/.elasticbeanstalk/config.yml"
      end

      def sync_eb_config_yml(force=false)
        # should break out to another class but too much work right now
        create = Create.new(@options)
        create.ensure_eb_init
        do_sync_eb_config_yml(force)
      end

    private

      # force flag for specs
      def do_sync_eb_config_yml(force)
        return if @options[:noop] and !force
        envs = describe_environments
        env = envs[:environments].first
        if env
          write_eb_config_yml(env.application_name, env.solution_stack_name)
        else
          UI.say "#{@env_name} could not be found".colorize(:red)
          exit 0
        end
      end

      def write_eb_config_yml(application_name, solution_stack_name)
        data = YAML.load_file(eb_config_path)
        data['global']['application_name'] = application_name
        data['global']['default_platform'] = solution_stack_name
        dump = YAML.dump(data).gsub("!ruby/object:Hash", '')
        dump = dump.split("\n")[1..-1].join("\n") # strip first line
        File.write(eb_config_path, dump)
      end

      # useful for specs
      def describe_environments
        eb.describe_environments(environment_names: [@env_name])
      end

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