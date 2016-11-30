require 'thor'
require 'jack/cli/help'
require 'jack/version_checker'
Jack::VersionChecker.new.run unless ENV['TEST']

module Jack
  class Config < Thor
    desc "upload ENV_NAME", "upload and apply jack config changes to EB environment"
    long_desc Jack::CLI::Help.upload
    option :force, aliases: :f, type: :boolean, desc: "skip prompt"
    def upload(env_name)
      Jack::Config::Upload.new(options.merge(env_name: env_name)).run
    end

    desc "download ENV_NAME", "downloads environment config to jack/cfg folder"
    long_desc Jack::CLI::Help.download
    option :dirty, type: :boolean, desc: "leave the remote eb config and download config behind"
    def download(env_name)
      Jack::Config::Download.new(options.merge(env_name: env_name)).run
    end

    desc "diff ENV_NAME", "diff jack config vs environment config"
    long_desc Jack::CLI::Help.diff
    option :dirty, type: :boolean, desc: "leave the remote eb config and download config behind"
    def diff(env_name)
      Jack::Config::Diff.new(options.merge(env_name: env_name)).run
    end

    desc "sort ENV_NAME", "reformat local jack config file to a sorted yaml file format"
    long_desc Jack::CLI::Help.sort
    def sort(env_name)
      Jack::Config::Sort.new(options.merge(env_name: env_name)).run
    end
  end

  class CLI < Thor
    class_option :verbose, type: :boolean
    class_option :mute, type: :boolean, desc: "mute all output, useful for specs"
    class_option :noop, type: :boolean, desc: "dont run any destructive commands"
    class_option :force, type: :boolean, desc: "bypass confirmation prompt"
    class_option :root, :default => '.', desc: "root of the project, useful for specs"
    class_option :cfg, aliases: :c, desc: "local config name if want to override the convention"
    class_option :app, aliases: :a, desc: "app name if want to override the convention"

    desc "create ENV_NAME", "create EB environment"
    long_desc Help.create
    def create(env_name)
      Jack::Create.new(options.merge(env_name: env_name)).run
    end

    desc "version", "display jack version number"
    def version
      puts Jack::VERSION
    end

    desc "config ACTION ENV_NAME", "manage environment config"
    long_desc Help.config
    subcommand "config", Config
  end
end
