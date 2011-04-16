require 'win32ole'

path = File.expand_path(File.dirname(__FILE__))

require File.join(path, 'string.rb')

requires = 
[
  'inetmgr/iis_object_collection.rb',
  'inetmgr/iis_object.rb'
]

requires.each do |file|
	require File.join(path, file)
end

requires =
[
  'inetmgr/configuration.rb',
  'inetmgr/iis_configuration.rb',
  'inetmgr/site_configuration.rb'
]

requires.each do |file|
	require File.join(path, file)
end

Dir.glob(File.join(path, 'inetmgr/iis_object/*.rb')).each do |f|
	require f unless requires.include?(f)
end
