module Jack
  class Deploy
    include Util

    def initialize(options={})
      @options = options
      @root = options[:root] || '.'
      @env_name = options[:env_name]
      @app_name = options[:app] || app_name_convention(@env_name)
    end

    def run
      unless @options[:noop] || environment_exists?
        UI.say("ERROR: Environment #{@env_name} does not appear to exist. Are you sure it exists?")
        exit 1 unless ENV['TEST']
      end

      prerequisites
      deploy
    end

    def environment_exists?
      return true if @options[:noop]
      r = eb.describe_environments(application_name: @app_name)
      r.environments.collect(&:environment_name).include?(@env_name)
    end

    def deploy
      # EB_OPTIONS are passed through to the underlying eb deploy command
      #
      # optional arguments:
      #   -h, --help            show this help message and exit
      #   --debug               toggle debug output
      #   --quiet               suppress all output
      #   -v, --verbose         toggle verbose output
      #   --profile PROFILE     use a specific profile from your credential file
      #   -r REGION, --region REGION
      #                         use a specific region
      #   --no-verify-ssl       do not verify AWS SSL certificates
      #   --modules [MODULES [MODULES ...]]
      #                         modules to deploy
      #   -g ENV_GROUP_SUFFIX, --env-group-suffix ENV_GROUP_SUFFIX
      #                         group suffix
      #   --version VERSION     existing version label to deploy
      #   -l LABEL, --label LABEL
      #                         label name which version will be given
      #   -m MESSAGE, --message MESSAGE
      #                         description for version
      #   -nh, --nohang         return immediately, do not wait for deploy to be
      #                         completed
      #   --staged              deploy files staged in git rather than the HEAD commit
      #   --timeout TIMEOUT     timeout period in minutes
      #   --source SOURCE       source of code to deploy directly; example
      #                         source_location/repo/branch
      #   -p, --process         enable preprocessing of the application version
      command = "#{eb_bin} deploy#{eb_base_flags} #{@env_name} #{ENV['EB_OPTIONS']}"
      sh(command)
    end
  end
end
