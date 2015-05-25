module Jack
  class CLI < Thor
    class Help
      class << self
        def convention
<<-EOL
The configuration name is based on convention.  An environment with the name of stag-rails-app-s1 results in the jack/cfg/stag-rails-app.cfg.yml being used.  The convention can be overriden with the --cfg option.  
EOL
        end

        def create
<<-EOL
Creates a new environment using the configuration in jack/cfg folder.  

#{convention}

Example:

$ jack create stag-rails-app-s1

$ jack create -c myconfig stag-rails-app-s1

$ jack create -a myapp -c myconfig stag-rails-app-s1
EOL
        end
 
        def upload
<<-EOL
Uploads the specified template configuration in jack/cfg and applies it to the environment immediately.  

#{convention}

Example:

$ jack config upload stag-rails-app-s1

$ jack config upload myapp -c myconfig stag-rails-app-s1
EOL
        end

        def download
<<-EOL
Downloads the environment's config to jack/cfg/[CONFIG_NAME].cfg.yml

#{convention}

Example:

$ jack config download stag-rails-app-s1

$ jack config download myapp -c myconfig stag-rails-app-s1
EOL
        end


        def diff
<<-EOL
Diff local jack config vs environment config.  The environment config is generated on the fly.

If you have colordiff installed the diff command will use make use of it.  If you want to have your own custom diff, you can set your JACK_DIFF environment variable to it.

#{convention}

Example:

$ jack config diff stag-rails-app-s1

$ jack config diff myapp -c myconfig stag-rails-app-s1
EOL
        end

        def sort
<<-EOL
Reformats local jack config file to a sorted yaml format.

#{convention}

Example:

$ jack config sort stag-rails-app-s1

$ jack config sort -c myconfig stag-rails-app-s1 # env name doesnt matter here
EOL
        end

        # dumb thor bug, so this doesnt even show, leaving here in case Thor is fixed
        def config
<<-EOL
Manage the environment's config.  Can use this to download the environment's config to jack/cfg folder or upload config in jack/cfg folder and apply it to the environment.

Example:

$ jack config download stag-rails-app-s1

For more info:

$ jack help config

$ jack config help apply

$ jack config help download
EOL
        end
      end
    end
  end
end