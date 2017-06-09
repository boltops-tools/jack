class Jack::Config::Help
  class << self
    def upload
<<-EOL
Uploads the specified template configuration in jack/cfg and applies it to the environment immediately.

#{convention}

Example:

$ jack config upload hi-web-stag-1

$ jack config upload myapp -c myconfig hi-web-stag-1
EOL
    end

    def download
<<-EOL
Downloads the environment's config to jack/cfg/[CONFIG_NAME].cfg.yml

#{convention}

Example:

$ jack config download hi-web-stag-1

$ jack config download myapp -c myconfig hi-web-stag-1
EOL
    end


    def diff
<<-EOL
Diff local jack config vs environment config.  The environment config is generated on the fly.

If you have colordiff installed the diff command will use make use of it.  If you want to have your own custom diff, you can set your JACK_DIFF environment variable to it.

#{convention}

Example:

$ jack config diff hi-web-stag-1

$ jack config diff myapp -c myconfig hi-web-stag-1
EOL
    end

    def sort
<<-EOL
Reformats local jack config file to a sorted yaml format.

#{convention}

Example:

$ jack config sort hi-web-stag-1

$ jack config sort -c myconfig hi-web-stag-1 # env name doesnt matter here
EOL
    end

private
    # duplicated in jack/help.rb
    def convention
<<-EOL
The configuration name is based on convention.  An environment with the name of hi-web-stag-1 results in the jack/cfg/hi-web-stag.cfg.yml being used.  The convention can be overriden with the --cfg option.
EOL
    end
  end
end
