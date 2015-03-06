module Jack
  class CreateYaml
    def data
      return @create_yaml if @create_yaml

      project_file = "#{@root}/jack/create.yml"
      project = File.exist?(project_file) ? YAML.load_file(project_file) : {}

      user_file = "#{ENV['HOME']}/.jack/create.yml"
      user = File.exist?(user_file) ? YAML.load_file(user_file) : {}

      default_file = File.expand_path("../default/create.yml", __FILE__)
      default = YAML.load_file(default_file)

      @create_yaml = default.merge(project.merge(user))
    end

    def flags
      data.inject("") {|s,(k,v)| s << %{--#{k} "#{v}" } ; s }.strip
    end
  end
end