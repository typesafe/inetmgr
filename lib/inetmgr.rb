require 'win32ole'

path = File.expand_path(File.dirname(__FILE__))

requires = 
[
  'inetmgr/iis_object_collection.rb',
  'inetmgr/iis_object.rb',
  'inetmgr/iis_object/virtual_directory.rb',
  'inetmgr/iis_object/application.rb',
  'inetmgr/iis_object/binding_information.rb',
  'inetmgr/iis_object/site.rb'
]

requires.each do |file|
	require File.join(path, file)
end

Dir.glob(File.join(path, 'inetmgr/iis_object/*.rb')).each do |f|
	require f unless requires.include?(f)
end

require File.join(path, 'inetmgr/configuration.rb')
require File.join(path, 'inetmgr/iis_configuration.rb')
require File.join(path, 'inetmgr/Site_configuration.rb')