require 'fileutils'

module Jack
  class Config < Thor
    class Upload < Transmit
      include Util

      attr_reader :upload_path, :upload_name

      def initialize(options={})
        super
        @upload_path = "#{@saved_configs}/#{@env_name}-#{timestamp}.cfg.yml"
        @upload_name = extract_name(@upload_path)
      end

      def run
        unless local_cfg_exist?
          UI.say "#{local_config_path} does not exist, nothing to upload"
          exit 0
        end
        compare
        if confirm
          upload
          update_env
        end
      end

      def compare
        Diff.new(@options).run
      end

      def upload
        return false unless local_cfg_exist?
        UI.say("Copying #{@local_config_path} to #{@upload_path} for the upload")
        cp_to_save_configs
        upload_to_eb
        clean_up
      end

      def confirm
        UI.say("Are you sure you want to update the environment with your the new config #{@config_path}?".colorize(:yellow))
        UI.say(<<-EOL)
If the difference is not what you expected, you should say no.
A blank newline indicates that there was no difference.
If you want to download the config from the environment and
overwrite your #{@local_config_path} instead, you can use this command:
$ jack config download #{@env_name}
$ jack config help download # for more info
EOL
        print "yes/no? [no] " unless @options[:mute] || @options[:force]
        answer = get_answer
        answer =~ /^y/
      end

      def get_answer
        return 'y' if @options[:force]
        $stdin.gets
      end

      def update_env
        UI.say("Updating environment #{@env_name} with template #{upload_name}")
        eb.update_environment(
          environment_name: @env_name,
          template_name: upload_name
        ) unless @options[:noop]
      end

      def local_cfg_exist?
        File.exist?("#{@root}/#{@local_config_path}")
      end

      def cp_to_save_configs
        ensure_folder_exist(@saved_configs)
        FileUtils.cp("#{@root}/#{@local_config_path}", @upload_path)
      end

      def upload_to_eb
        eb_config_put
      end

      # for specs
      def eb_config_put
        do_cmd("eb config put #{upload_name}", @options)
      end

      def clean_up
        return if @options[:dirty]
        FileUtils.rm_f(@upload_path)
      end

    end
  end
end
