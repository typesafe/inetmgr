require 'win32ole'

path = File.expand_path(File.dirname(__FILE__))

require File.join(path, 'inetmgr/win32_ole.rb')
require File.join(path, 'inetmgr/iis_object_collection.rb')
require File.join(path, 'inetmgr/iis_object.rb')
#require File.join(path, 'inetmgr/binding_information.rb')

require File.join(path, 'inetmgr/iis_object/virtual_directory.rb')

Dir.glob(File.join(path, 'inetmgr/iis_object/*.rb')).each {|f| require f }

require File.join(path, 'inetmgr/iis_configuration.rb')
