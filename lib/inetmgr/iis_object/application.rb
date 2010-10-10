class Application  < IisObject

  def add_virtual_directory path, physical_directory
    e = @element.add_element "virtualDirectory" do |e|
      e.set "path", path
      e.set "physicalPath", physical_directory    
    end
    VirtualDirectory.new(e)
  end
    
	
#	attr_accessor :site
#	attr_accessor :path
#	attr_accessor :physical_path
#	attr_accessor :preloader
#
#	def create
#		site = Site.get @site
#		fail "site #{@site} does not exist" if site.nil?
#
#		site.add_element "application" do |app|
#			app.set "Path", @path
#			app.set "serviceAutoStartEnabled", @preloader != nil
#			app.set "serviceAutoStartProvider", @preloader unless @preloader == nil
#
#			app.add_element "virtualDirectory" do |e|
#				e.set "path", "/"
#				e.set "physicalPath", @physical_path
#			end
#		end
#	end
end