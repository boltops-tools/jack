module Jack
  class Terminate
    include Util

    def initialize(options={})
      @options = options
      @root = options[:root] || '.'
      @env_name = options[:env_name]
      @app_name = options[:app] || app_name_convention(@env_name)
    end

    def run
      check_aws_setup
      message = "Are you sure you want to delete the environment #{@env_name}?".colorize(:yellow)
      if confirm(message) && !@options[:noop]
        eb.terminate_environment(environment_name: @env_name)
        UI.say("Environment #{@env_name} is terminating!")
      else
        UI.say("Whew that was close. Environment #{@env_name} was not deleted.")
      end
    end
  end
end
