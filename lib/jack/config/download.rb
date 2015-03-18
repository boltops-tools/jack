require 'fileutils'
require 'yaml'

module Jack
  module Config
    class Download < Transmit
      include Util

      attr_reader :current_path, :current_name

      def initialize(options={})
        super
        @current_path = "#{@saved_configs}/current-#{timestamp}.cfg.yml"
        @current_name = extract_name(@current_path)
        @updater = EbConfig::Update.new(env_name: @env_name)
        @updater.sync unless options[:noop]
      end

      def run
        download
      end

      def download
        # add_gitignore
        get_current_cfg
        copy_to_local_cfg
        clean
        UI.say "Config downloaded to #{@local_config_path}".colorize(:green)
      end

      def add_gitignore
        path = "#{@root}/.gitignore"
        if File.exist?(path)
          ignores = IO.read(path)
          has_ignore = ignores.include?("jack/cfg")
        end
        do_cmd("echo 'jack/cfg/*.yml' >> #{path}") unless has_ignore
      end

      def get_current_cfg
        UI.say "Downloading config file..."
        eb_config_save
      end

      # for specs
      def eb_config_save
        do_cmd("eb config save --cfg #{current_name} #{@env_name}", @options)
      end

      def copy_to_local_cfg
        UI.say "Writing to local config file: #{@local_config_path}"
        dirname = File.dirname("#{@root}/#{@local_config_path}")
        FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
        do_copy_to_local_cfg
      end

      # for specs
      def do_copy_to_local_cfg
        return if @options[:noop]
        local_path = "#{@root}/#{@local_config_path}"
        FileUtils.cp(@current_path, local_path) 
        YamlFormatter.new.process(local_path)
      end

      # remove both the local download file and remote eb config
      def clean(silent=false)
        return if @options[:dirty]
        UI.say "Cleaning up eb remote config and local files" unless silent
        eb.delete_configuration_template(
          application_name: @updater.app_name,
          template_name: current_name
        ) unless @options[:noop]
        FileUtils.rm_f(@current_path)
      end

    end
  end
end