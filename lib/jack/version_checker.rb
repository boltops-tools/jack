module Jack
  class VersionChecker
    REQUIRED_VERSION = "3.1.2"
    include Util

    def run
      leave(not_installed) unless system("type #{eb_bin} > /dev/null 2>&1")
      leave(version_too_low) unless check
    end

    def check
      major, minor, patch = version_parts(parsed_version)
      r_major, r_minor, r_patch = version_parts(REQUIRED_VERSION)
      (major > r_major) ||
      (major == r_major && minor > r_minor) ||
      (major == r_major && minor == r_minor && patch >= r_patch)
    end

    def get_version
      command = "#{eb_bin} --version"
      puts "command: #{command}"
      `#{eb_bin} --version`
    end

    def parsed_version
      @parsed_version ||= parse_version(get_version)
    end

    def parse_version(version)
      parsed = version.match(/EB CLI (\d+\.\d+\.\d+)/)[1]
    end


    def version_parts(parsed)
      parsed.split('.').collect(&:to_i)
    end

    def not_installed
      message = "Unable to detect an installation of the eb cli tool. Please install the eb tool.\n\n"
      message << install_instructions
      message
    end

    def version_too_low
      <<~EOS
        Unable to detect a version of the eb cli tool that works with jack.
        Detected version #{parsed_version}.

        #{install_instructions}
      EOS
    end

    def install_instructions
      if RUBY_PLATFORM =~ /darwin/
        "You can install the eb tool via homebrew:\n\nbrew install awsebcli"
      else
        "Installation instructions: http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html"
      end
    end

    # for specs
    def leave(message)
      puts(message)
      exit 0
    end
  end
end
