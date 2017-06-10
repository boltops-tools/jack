require 'thor'
require 'jack/command'
require 'jack/version_checker'
Jack::VersionChecker.new.run unless ENV['TEST']

module Jack
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :mute, type: :boolean, desc: "mute all output, useful for specs"
    class_option :noop, type: :boolean, desc: "dont run any destructive commands"
    class_option :sure, type: :boolean, desc: "bypass confirmation prompt"
    class_option :root, :default => '.', desc: "root of the project, useful for specs"
    class_option :cfg, aliases: :c, desc: "local config name if want to override the convention"
    class_option :app, aliases: :a, desc: "app name if want to override the convention"

    desc "create ENV_NAME", "create EB environment"
    long_desc Help.create
    def create(env_name)
      Create.new(options.merge(env_name: env_name)).run
    end

    desc "deploy ENV_NAME", "deploy to EB environment"
    long_desc Help.deploy
    def deploy(env_name)
      Deploy.new(options.merge(env_name: env_name)).run
    end

    desc "terminate ENV_NAME", "deletes EB environment"
    long_desc Help.terminate
    def terminate(env_name)
      Terminate.new(options.merge(env_name: env_name)).run
    end

    desc "apply ENV_NAME", "apply jack config changes to EB environment"
    long_desc Config::Help.apply
    option :sure, aliases: :f, type: :boolean, desc: "skip prompt"
    def apply(env_name)
      Config::Apply.new(options.merge(env_name: env_name)).run
    end

    desc "get ENV_NAME", "downloads environment config to jack/cfg folder"
    long_desc Config::Help.get
    option :dirty, type: :boolean, desc: "leave the remote eb config and downloaded config behind"
    def get(env_name)
      Config::Get.new(options.merge(env_name: env_name)).run
    end

    desc "diff ENV_NAME", "diff jack config vs environment config"
    long_desc Config::Help.diff
    option :dirty, type: :boolean, desc: "leave the remote eb config and downloaded config behind"
    def diff(env_name)
      Config::Diff.new(options.merge(env_name: env_name)).run
    end

    desc "sort ENV_NAME", "reformat local jack config file to a sorted yaml file format"
    long_desc Config::Help.sort
    def sort(env_name)
      Config::Sort.new(options.merge(env_name: env_name)).run
    end

    desc "version", "display jack version number"
    def version
      puts VERSION
    end
  end
end
