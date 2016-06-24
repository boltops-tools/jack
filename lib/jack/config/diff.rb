module Jack
  module Config
    class Diff
      attr_reader :transmit
      def initialize(options={})
        @options = options
        @root = options[:root] || '.'
        @env_name = options[:env_name]
        @download = Jack::Config::Download.new(options)
      end

      def run
        @download.get_current_cfg
        do_diff(@download.current_path, @download.local_config_path)
        cleanup_files
      end

      def do_diff(current, local)
        UI.say "Comparing #{current} and #{local}"
        return if @options[:noop]
        sorter = YamlFormatter.new
        sorter.process(current)
        sorter.process(local)
        # need to use system so that the diff shows up properly in the terminal
        system(diff_command, @download.current_path, @download.local_config_path)
        puts ""
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
