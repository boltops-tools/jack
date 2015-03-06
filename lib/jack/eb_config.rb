require 'fileutils'

module Jack
  module EbConfig
    autoload :Base, 'jack/eb_config/base'
    autoload :Update, 'jack/eb_config/update'
    autoload :Create, 'jack/eb_config/create'
  end
end