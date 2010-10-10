class Site < IisObject

	prop "application_pool",          "applicationPool",                Proc.new { |a| a },      Proc.new {|value| value }

  def add_virtual_directory name, physical_directory
    get_applications[0].add_virtual_directory name, physical_directory
  end

	def add_application path
		@element.add_element "application" do |e|
			e.set "path", path
	    end
	end
  

    def get_applications
	    apps = []
        @element.for_each do |a|
	        apps << Application.new(a)
        end
        apps
    end

    def get_application(path)
	     @element.for_each do |a|
		     return Application.new(a) if a.get("path") == path
	     end
        nil
    end

#
#	attr_accessor :name
#	attr_accessor :physical_path
#	attr_accessor :bindings
#	attr_accessor :auto_start
#	attr_accessor :application_pool
#	attr_accessor :enabledProtocols
#	attr_accessor :preloader
#	attr_accessor :enable_anonymous_authentication
#	attr_accessor :enable_basic_authentication
#	attr_accessor :enable_windows_authentication
#
#	def create
#
#			sites = get_section "system.applicationHost/sites"
#
#			sites.add_element "site" do |site|
#			    site.set "name", @name
#				site.set "id", sites.Collection.Count + 1 # define method for this
#				site.set "serverAutoStart", @auto_start if @auto_start == true
#
#				bindings = site.get_child_element "bindings"
#				get_bindings.each do |b|
#					bindings.add_element "binding" do |binding|
#						binding.set "protocol", b.protocol
#						binding.set "bindingInformation", b.binding_information
#					end
#				end
#			end
#
#			ensure_pool
#
#			app = Application.new
#			app.site = @name
#			app.path = "/"
#			app.physical_path = @physical_path
#			app.preloader = @preloader
#			app.create
#
#			#application = element.Collection.CreateNewElement("application")
#			#application.Properties.Item("path").Value = "/"
#			#application.Properties.Item("applicationPool").Value = @application_pool
#			#application.Properties.Item("enabledProtocols").Value = @enabledProtocols unless @enabledProtocols == nil
#			#application.Properties.Item("serviceAutoStartEnabled").Value = @serviceAutoStartProvider != nil
#			#application.Properties.Item("serviceAutoStartProvider").Value = @serviceAutoStartProvider unless @serviceAutoStartProvider == nil
#			#element.Collection.AddElement application
#
#			#virtual_directory = application.Collection.CreateNewElement("virtualDirectory")
#			#virtual_directory.Properties.Item("path").Value = "/"
#			#virtual_directory.Properties.Item("physicalPath").Value = @physical_path
#			#application.Collection.AddElement(virtual_directory)
#
#			#set_authentication_enabled @enable_anonymous_authentication, "anonymousAuthentication"
#			#set_authentication_enabled @enable_basic_authentication, "basicAuthentication"
#			#set_authentication_enabled @enable_windows_authentication, "windowsAuthentication"
#
#	end
#
#	def add_virtual_directory path, physical_path
#
#
#
#	end
#
#private
#
#	def set_authentication_enabled(value, type)
#		unless value == nil
#			s = m.get_config_section "system.webServer/security/authentication/" + type, "MACHINE/WEBROOT/APPHOST/" + @name
#			s.Properties.Item("enabled").Value = value
#		end
#	end
#
#  def ensure_pool
#    @application_pool = @name if @application_pool == nil
#
#    pool = ApplicationPool.get @application_pool
#
#    if pool == nil
#      pool = ApplicationPool.new
#      pool.name = @application_pool
#      pool.create
#    end
#
#  end
#
#  def get_bindings
#    @bindings = [BindingInformation.new] if @bindings == nil
#    @bindings
#  end
#
#  def self.get(name)
#    s = get_section "system.applicationHost/sites"
#    s.Collection.Count.times do |i|
#      p = s.Collection.Item i
#      return p if p.Properties.Item("name").Value == name
#    end
#    nil
#  end

end
