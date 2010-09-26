class VirtualDirectory < IisObject
  attr_accessor :path
  attr_accessor :physical_path
  attr_accessor :site

  def initialize(path = nil, physical_path = nil, site = nil)
    @path = path
    @physical_path = physical_path
    @site = site 
  end

  def create
    configure do |m|
      site = Site.get @site, m
      app = site.Collection.Item 0

      virtual_directory = app.Collection.CreateNewElement("virtualDirectory")
      virtual_directory.Properties.Item("path").Value = @path
      virtual_directory.Properties.Item("physicalPath").Value = @physical_path
      app.Collection.AddElement(virtual_directory)
      
    end
  end

  
end