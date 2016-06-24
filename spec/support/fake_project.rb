class FakeProject
  def initialize(root)
    @root = root || '.'
  end

  def create_eb_config
    data = <<-EOL
--- 
global:
  application_name: blah
  default_platform: 64bit Amazon Linux 2014.09 v1.2.0 running Docker 1.3.3
EOL
    path = "#{@root}/.elasticbeanstalk/config.yml"
    create_file(path, data)
  end

  def create_settings
    data = <<-EOL
create:
  keyname: default
  platform: "Fake Platform From Project Settings"
EOL
    create_file(settings_path, data)
  end

  def remove_settings
    remove_file(settings_path)
  end

  def settings_path
    "#{@root}/jack/settings.yml"
  end

  def create_file(path, contents)
    ensure_parent_folder(path)
    File.write(path, contents) unless File.exist?(path)
  end

  def remove_file(path)
    FileUtils.rm_f(path)
  end

  def ensure_parent_folder(path)
    dir = File.dirname(path)
    FileUtils.mkdir_p(dir) unless File.exist?(path)
  end
end
