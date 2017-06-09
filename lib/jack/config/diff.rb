module Jack
  class Config < Command
    class Diff
      attr_reader :transmit
      def initialize(options={})
        @options = options
        @root = options[:root] || '.'
        @env_name = options[:env_name]
        @download = Jack::Config::Get.new(options)
      end

      def run
        @download.get_current_cfg
        difference = compute_diff(@download.current_path, @download.local_config_path)
        cleanup_files
        difference
      end

      def compute_diff(current, local)
        # the diff command returns 0 when there is no difference and returns 1 when there is a difference
        pretty_current_path = @download.current_path.sub(/.*\.elasticbeanstalk/,'.elasticbeanstalk')
        command = "#{diff_command} #{pretty_current_path} #{@download.local_config_path}"
        UI.say("=> #{command}")

        return if @options[:noop]
        sorter = YamlFormatter.new
        sorter.process(current)
        sorter.process(local)

        no_difference = system(command)
        !no_difference
      end

      def cleanup_files
        return false if @options[:dirty]
        @download.clean(mute=true)
      end

      def diff_command
        return ENV['JACK_DIFF'] if ENV['JACK_DIFF']
        if system("type colordiff > /dev/null 2>&1")
          "colordiff"
        else
          "diff"
        end
      end
    end
  end
end
