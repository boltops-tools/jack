module Jack
  module EbConfig
    class Update < Base
      attr_reader :eb_config_path
      def initialize(options={})
        super
      end

      def platform
        env.solution_stack_name
      end

      def app_name
        env.application_name
      end

      def env
        return @env if @env
        envs = describe_environments
        @env = envs[:environments].first
        unless @env
          abort("ERROR: Environment #{@env_name} not found.  Are you sure it exists?".colorize(:red))
        end
        @env
      end

      # useful for specs
      def describe_environments
        eb.describe_environments(environment_names: [@env_name])
      end
    end
  end
end
