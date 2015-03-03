require "yaml"

module Jack
  class Create
    include Util

    def initialize(options={})
      @options = options
      @root = options[:root] || '.'
      @env_name = options[:env_name]
      @app_name = options[:app_name] || app_name_convention(@env_name)
    end

    def run
      ensure_eb_init
      create_env
    end

    def ensure_eb_init
      unless File.exist?("#{@root}/.elasticbeanstalk/config.yml")
        do_cmd(%Q|eb init -p "#{create_yaml['platform']}" "#{@app_name}"|, @options)
      end
    end

    def create_env
      command = build_command
      do_cmd(command, @options)
    end

    def build_command
      @cfg = upload_cfg
      flags = create_yaml.inject("") {|s,(k,v)| s << %{--#{k} "#{v}" } ; s }.strip
      "eb create --nohang #{flags} #{@cfg}#{cname}#{@env_name}"
    end

    def create_yaml
      return @create_yaml if @create_yaml

      project_file = "#{@root}/jack/create.yml"
      project = File.exist?(project_file) ? YAML.load_file(project_file) : {}

      user_file = "#{ENV['HOME']}/.jack/create.yml"
      user = File.exist?(user_file) ? YAML.load_file(user_file) : {}

      default_file = File.expand_path("../default/create.yml", __FILE__)
      default = YAML.load_file(default_file)

      @create_yaml = default.merge(project.merge(user))
    end

    def upload_cfg
      @upload = Config::Upload.new(@options)
      if @upload.local_cfg_exist?
        @upload.upload 
        cfg = "--cfg #{@upload.upload_name} "
      end
    end

    def cname
      "--cname #{@env_name} "
    end
  end
end