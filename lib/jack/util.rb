# Any class that includes this module should define @root as it is used in
# the settings method.
module Jack::Util
  def confirm(message)
    Jack::UI.say(message)
    print "yes/no? [no] " unless @options[:mute] || @options[:sure]
    answer = get_answer
    answer =~ /^y/
  end

  def get_answer
    return 'y' if @options[:sure]
    $stdin.gets
  end

  def sh(command, options={})
    Jack::UI.say "=> #{command.colorize(:green)}"
    return command if @options[:noop]

    if options[:backtick]
      out = `#{command}`
      Jack::UI.say out
      success = $?.success?
    else
      success = system(command)
    end

    abort "Exiting! Error running command: #{command}".colorize(:red) unless success
  end

  def app_name_convention(env_name)
    pattern = settings.app_name_pattern
    env_name.match(pattern)[1]
  end

  def settings
    # do not like the instance @root variable in this module but better
    # than having to pass settings around
    @settings ||= Jack::Settings.new(@root)
  end

  def eb
    @@eb ||= Aws::ElasticBeanstalk::Client.new
  end

  def ensure_folder_exist(folder)
    FileUtils.mkdir_p(folder) unless File.exist?(folder)
  end

  # Checks main if the ~/.aws/config has been set up properly. If it has not
  # print a message to the user and exit the program.
  def check_aws_setup
    # abusing `aws configure get region` to check that aws is probably properly configured
    get_region # method will exits when unable to query for the region
  end

  # get the region from ~/.aws/config settings
  # The eb tool reqiures you to specify the region when you run `eb init`. After that
  # the setting is saved in the ~/.elasticbeanstalk folder.  We will default to what
  # is set in ~/.aws/config.
  def get_region
    return 'us-west-2' if ENV['TEST']

    command = "#{aws_bin} configure get region"
    region = `#{command}`.strip
    success = $?.success?
    unless success
      abort <<~EOS.colorize(:red)
        ERROR: Unable to infer the region from your ~/.aws/config settings with command: `#{command}`.
        Maybe it is not properly configured? Please double check ~/.aws/config.
        If you haven't set your region yet, ou can set your region with `aws configure set region REGION`. Example:
        aws configure set region us-west-2
      EOS
    end

    # Defaults to us-east-1:
    # right now aws configure get region will actually return an error 1 code so we
    # will never default to us-east-1 here but doing this just in case the return code
    # changes to 0.
    region == '' ? 'us-east-1' : region
  end

  @@aws_bin = nil
  # Auto detects the aws binary for use, will use an aws binary based on the following precedence:
  #
  #   1. JACK_AWS_BIN environmental variable
  #   2. aws detected using the load path.
  #      For example: /usr/bin/local/aws if /usr/bin/local/ is earlest in the load path.
  #   3. /opt/bolts/embedded/bin/aws - This comes packaged with the the bolts toolbelt.
  #      https://boltops.com/toolbelt
  #
  # If an aws installation is not deetcted it'll display a message and exit the program.
  def aws_bin
    return @@aws_bin if @@aws_bin

    return @@aws_bin = "aws" if ENV['TEST']

    return @@aws_bin = ENV["JACK_AWS_BIN"] if ENV["JACK_AWS_BIN"]

    which_aws = `which aws`.strip
    return @@aws_bin = which_aws if which_aws != ''

    embedded_aws = "/opt/bolts/embedded/bin/aws"
    return @@aws_bin = embedded_aws if File.exist?(embedded_aws)

    # if reach here we did not detect the eb binary
    message = "ERROR: Unable to auto detect an aws executable. Please make sure you have installed the aws cli tool.\n"
    message << if RUBY_PLATFORM =~ /darwin/
        "You can install the aws tool via homebrew:\n\nbrew install awscli"
      else
        "Installation instructions: http://docs.aws.amazon.com/cli/latest/userguide/installing.html"
      end
    abort(message)
  end

  @@eb_bin = nil
  # Auto detects the eb binary for use, will use an eb binary based on the following precedence:
  #
  #   1. JACK_EB_BIN environmental variable
  #   2. eb detected using the load path.
  #      For example: /usr/bin/local/eb if /usr/bin/local/ is earlest in the load path.
  #   3. /opt/bolts/embedded/bin/eb - This comes packaged with the the bolts toolbelt.
  #      https://boltops.com/toolbelt
  #
  # If an eb installation is not deetcted it'll display a message and exit the program.
  def eb_bin
    return @@eb_bin if @@eb_bin

    return @@eb_bin = "eb" if ENV['TEST']

    return @@eb_bin = ENV["JACK_EB_BIN"] if ENV["JACK_EB_BIN"]

    which_eb = `which eb`.strip
    return @@eb_bin = which_eb if which_eb != ''

    embedded_eb = "/opt/bolts/embedded/bin/eb"
    return @@eb_bin = embedded_eb if File.exist?(embedded_eb)

    # if reach here we did not detect the eb binary
    message = "ERROR: Unable to auto detect an eb executable. Please make sure you have installed the eb cli tool.\n"
    instructions = VersionChecker.new.install_instructions
    message << instructions
    abort(message)
  end

  def eb_base_flags
    return @eb_base_flags if @eb_base_flags
    region = get_region
    profile = ENV['AWS_PROFILE']
    flags = {
      profile: region ? " --profile #{profile}" : "",
      region: region ? " -r #{region}" : ""
    }
    @eb_base_flags = "#{flags[:profile]}#{flags[:region]}"
  end
end
