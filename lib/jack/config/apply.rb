require 'fileutils'

module Jack
  class Config < Command
    class Apply < Transmit
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
        difference = compare
        if difference
          if confirm(confirmation_message)
            upload
            update_env
          else
            UI.say("Whew, that was close. EB Configuration was not updated.")
          end
        else
          UI.say("There was no difference detected from your #{@local_config_path} and what exists on the EB environment")
        end
      end

      def confirmation_message
        message = "Are you sure you want to update the environment with your the new config #{@local_config_path}?\n".colorize(:yellow)
        message += <<-EOL
If the difference is not what you expected, you should say no.
If you want to download the config from the environment and get #{@local_config_path}
back in sync, you can use this command:
  $ jack config get #{@env_name}
  $ jack config get -h # for more info
EOL
        message
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

      def update_env
        UI.say("Updating environment #{@env_name} with template #{upload_name}")
        begin
          eb.update_environment(
            environment_name: @env_name,
            template_name: upload_name
          ) unless @options[:noop]
        rescue Aws::ElasticBeanstalk::Errors::InvalidParameterValue => e
          puts "ERROR: Unable to update the environment: #{@env_name}".colorize(:red)
          puts e.message.colorize(:red)
          exit 1
        end
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
        sh("#{eb_bin} config put#{eb_base_flags} #{upload_name}", @options)
      end

      def clean_up
        return if @options[:dirty]
        FileUtils.rm_f(@upload_path)
      end

    end
  end
end
