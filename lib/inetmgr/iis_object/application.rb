require File.join(File.expand_path(File.dirname(__FILE__)), 'virtual_directory.rb')

class Application  < IisObject

  prop :auto_start, "serviceAutoStartEnabled"
  prop :auto_start_provider, "serviceAutoStartProvider"
  prop :application_pool, :applicationPool
  
  collection :virtual_directories, :virtualDirectory, VirtualDirectory
 
end