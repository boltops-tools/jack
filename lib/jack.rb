$:.unshift(File.expand_path("../", __FILE__))
require "jack/version"
require "colorize"
require "aws-sdk"
require File.expand_path("../jack/ext/hash", __FILE__)

module Jack
  autoload :CLI, 'jack/cli'
  autoload :Create, 'jack/create'
  autoload :CreateYaml, 'jack/create_yaml'
  autoload :EbConfig, 'jack/eb_config'
  autoload :Config, 'jack/config'
  autoload :UI, 'jack/ui'
  autoload :Util, 'jack/util'
  autoload :VersionChecker, 'jack/version_checker'
end