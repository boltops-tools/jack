module Jack
  class Settings
    def initialize(root=nil)
      @root = root || '.'
    end

    # The options from the files get merged with the following precedence:
    #
    # current folder - The current folder’s jack/settings.yml values take the highest precedence.
    # user - The user’s ~/.jack/settings.yml values take the second highest precedence.
    # default - The default settings bundled with the tool takes the lowest precedence.
    #
    # More info: http://jack-eb.com/docs/settings/
    def data
      return @settings_yaml if @settings_yaml

      project_file = "#{@root}/jack/settings.yml"
      project = File.exist?(project_file) ? YAML.load_file(project_file) : {}

      user_file = "#{home}/.jack/settings.yml"
      user = File.exist?(user_file) ? YAML.load_file(user_file) : {}

      default_file = File.expand_path("../default/settings.yml", __FILE__)
      default = YAML.load_file(default_file)

      @settings_yaml = default.merge(user.merge(project))
    end

    def home
      # hack but fast
      ENV['TEST'] ? "spec/fixtures/home" : ENV['HOME']
    end

    def create_flags
      create.inject("") {|s,(k,v)| s << %{--#{k} "#{v}" } ; s }.strip
    end

    def create
      data["create"]
    end

    def app_name_pattern
      conventions["app_name_pattern"]
    end

    def conventions
      data["conventions"]
    end
  end
end
