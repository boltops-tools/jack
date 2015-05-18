module Jack
  module EbConfig
    class Create < Base
      attr_reader :eb_config_path
      def initialize(options={})
        super
        @app_name = options[:app] || app_name_convention(@env_name)
      end

      def platform
        CreateYaml.new.data['SolutionStack'] || latest_docker_platform
      end

      def app_name
        @app_name
      end

      def latest_docker_platform
        solution_stacks.grep(/Docker/).reject {|x| x =~ /Preconfigured/}.sort.last
      end
   
      def solution_stacks
        eb.list_available_solution_stacks.solution_stacks
      end

    end
  end
end
