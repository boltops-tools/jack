module Jack
  module EbConfig
    # Abstract Class
    # Concrete classes should implement methods: platform and app_name
    class Base
      include Util

      attr_reader :eb_config_path
      def initialize(options={})
        @options = options
        @root = options[:root] || '.'
        @env_name = options[:env_name]
        @eb_config_path = "#{@root}/.elasticbeanstalk/config.yml"
        ensure_folder_exist(File.dirname(@eb_config_path))
      end

      def sync
        ensure_eb_init
        write_eb_config_yml
      end

      def ensure_eb_init
        unless File.exist?(eb_config_path)
          do_cmd(%Q|eb init -r us-east-1 -p "#{platform}" "#{app_name}"|, @options)
        end
      end

      def write_eb_config_yml
        data = YAML.load_file(eb_config_path)
        data['global']['application_name'] = app_name
        data['global']['default_platform'] = platform
        dump = YAML.dump(data).gsub("!ruby/object:Hash", '')
        dump = dump.split("\n")[1..-1].join("\n") # strip first line
        File.write(eb_config_path, dump)
      end
    end
  end
end