module Jack
  class VersionChecker
    REQUIRED_VERSION = "3.1.2"

    def run
      leave("eb cli tool is not installed") unless system("type eb > /dev/null 2>&1")
      leave("eb version is too low") unless check
    end

    def check
      major, minor, patch = parse_version(get_version)
      r_major, r_minor, r_patch = normalize_version(REQUIRED_VERSION)
      (major > r_major) ||
      (major == r_major && minor > r_minor) ||
      (major == r_major && minor == r_minor && patch >= r_patch)
    end

    def get_version
      `eb --version`
    end

    def parse_version(version)
      parsed = version.match(/EB CLI (\d+\.\d+\.\d+)/)[1]
      normalize_version(parsed)
    end

    def normalize_version(parsed)
      parsed.split('.').collect(&:to_i)
    end

    # for specs
    def leave(message='')
      puts("SORRY: #{message}, please install at least version #{REQUIRED_VERSION}")
      exit 0
    end
  end
end