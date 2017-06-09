require 'fileutils'
require 'thor'

module Jack
  class Config < Command
    autoload :Help, 'jack/config/help'
    autoload :Base, 'jack/config/base'
    autoload :Diff, 'jack/config/diff'
    autoload :Get, 'jack/config/get'
    autoload :Sort, 'jack/config/sort'
    autoload :Transmit, 'jack/config/transmit'
    autoload :Apply, 'jack/config/apply'
    autoload :YamlFormatter, 'jack/config/yaml_formatter'
  end
end
