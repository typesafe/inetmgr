
path = File.expand_path(File.dirname(__FILE__))

require File.join(path, 'inetmgr/iis_object.rb')
Dir.glob(File.join(path, 'inetmgr/*.rb')).reject { |f| f if f.include? "iis_object" }.each {|f| require f }

Dir.glob(File.join(path, 'rake/*.rb')).each { |file| require file }