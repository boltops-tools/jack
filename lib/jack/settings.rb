module Jack
  class Settings
    def initialize(root=nil)
      @root = root || '.'
    end

    def data
      return @settings_yaml if @settings_yaml

      project_file = "#{@root}/jack/settings.yml"
      project = File.exist?(project_file) ? YAML.load_file(project_file) : {}

      user_file = "#{home}/.jack/settings.yml"
      user = File.exist?(user_file) ? YAML.load_file(user_file) : {}

      default_file = File.expand_path("../default/settings.yml", __FILE__)
      default = YAML.load_file(default_file)

      @settings_yaml = default.merge(project.merge(user))
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
      Regexp.new(conventions["app_name_pattern"])
    end

    def conventions
      data["conventions"]
    end
  end
end
