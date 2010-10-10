class Application  < IisObject

  prop :auto_start, "serviceAutoStartEnabled"
  prop :auto_start_provider, "serviceAutoStartProvider"
  
  def add_virtual_directory path, physical_directory
    e = @element.add_element "virtualDirectory" do |e|
      e.set "path", path
      e.set "physicalPath", physical_directory    
    end
    VirtualDirectory.new(e)
  end
  
end