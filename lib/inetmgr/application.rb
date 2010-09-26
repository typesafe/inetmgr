class Application  < IisObject

	attr_accessor :site
	attr_accessor :path
	attr_accessor :physical_path
	attr_accessor :preloader

	def create
		configure do |m|
			site = Site.get @site, m

			app = site.Collection.CreateNewElement "application"
			app.Properties.Item("Path").Value = @path
			app.Properties.Item("serviceAutoStartEnabled").Value = @preloader != nil
            app.Properties.Item("serviceAutoStartProvider").Value = @preloader unless @preloader == nil

			virtual_directory = app.Collection.CreateNewElement("virtualDirectory")
			virtual_directory.Properties.Item("path").Value = "/"
			virtual_directory.Properties.Item("physicalPath").Value = @physical_path
			app.Collection.AddElement virtual_directory

			site.Collection.AddElement app
		end
	end
end