module Jack
  class Help
    class << self
      def create
<<-EOL
Creates a new environment using the configuration in jack/cfg folder.  The AWS sample app is initially used for the newly created environment.  The sample app is used as a starting point to make sure that the environment is working before you introduce your own app code.

#{convention}

Example:

$ jack create hi-web-stag-1

$ jack create -c myconfig hi-web-stag-1

$ jack create -a myapp -c myconfig hi-web-stag-1
EOL
      end

      def terminate
<<-EOL
Deletes Elastic Beanstalk environment.

Example:

$ jack terminate hi-web-stag-1
EOL
      end

      # Thor auto generates the subcommand help menu.
      # Leaving here in case we figure out a way to override this Thor behavior.
      def config
<<-EOL
Manage the environment's config.  Can use this to download the environment's config to jack/cfg folder or upload and apply config in jack/cfg folder to the environment.

Example:

$ jack config get hi-web-stag-1

For more info:

$ jack help config

$ jack config help upload

$ jack config help download
EOL
      end

private
      # duplicated in jack/config/help.rb
      def convention
  <<-EOL
  The configuration name is based on convention.  An environment with the name of hi-web-stag-1 results in the jack/cfg/hi-web-stag.cfg.yml being used.  The convention can be overriden with the --cfg option.
  EOL
      end
    end
  end
end
