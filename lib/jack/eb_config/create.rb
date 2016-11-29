module Jack
  module EbConfig
    class Create < Base
      attr_reader :eb_config_path
      def initialize(options={})
        super
        @app_name = options[:app] || app_name_convention(@env_name)
      end

      def platform
        # TODO: change so that the gem default settins has nil for platform
        # but need to provide a deprecation warning first.
        # Right now it will never hit the lastest_docker_platform logic
        settings.create['platform'] || latest_docker_platform
      end

      def app_name
        @app_name
      end

      def latest_docker_platform
        solution_stacks.grep(/Docker/).
                        reject {|x| x =~ /Preconfigured/}.
                        reject {|x| x =~ /Multi-container/}.
                        sort.last
      end

      def solution_stacks
        eb.list_available_solution_stacks.solution_stacks
      end

    end
  end
end
