
class Application  < IisObject

  prop :auto_start, "serviceAutoStartEnabled"
  prop :auto_start_provider, "serviceAutoStartProvider"

  collection :virtual_directories, :virtualDirectory, VirtualDirectory
 
end