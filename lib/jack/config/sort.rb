require 'fileutils'

module Jack
  module Config
    class Sort < Transmit # for the local_config_path method
      include Util

      def initialize(options={})
        super
        @options = options
      end

      def run
        YamlFormatter.new.process("#{@root}/#{local_config_path}")
        UI.say "Reformatted the local config to a sorted yaml format at #{local_config_path}"
      end
    end
  end
end