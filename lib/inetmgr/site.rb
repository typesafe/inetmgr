class Site < IisObject
	attr_accessor :name
	attr_accessor :physical_path
	attr_accessor :bindings
	attr_accessor :auto_start
	attr_accessor :application_pool
	attr_accessor :enabledProtocols
	attr_accessor :preloader
	attr_accessor :enable_anonymous_authentication
	attr_accessor :enable_basic_authentication
	attr_accessor :enable_windows_authentication

	def create
		configure do |m|
			section = m.get_config_section "system.applicationHost/sites"
			element = section.Collection.CreateNewElement("site");
			element.Properties.Item("name").Value = @name
			element.Properties.Item("id").Value = section.Collection.Count + 1
			element.Properties.Item("serverAutoStart").Value = @auto_start if @auto_start == true

			bindings = element.ChildElements.Item("bindings").Collection
			get_bindings.each do |b|
				binding = bindings.CreateNewElement("binding")
				binding.Properties.Item("protocol").Value = b.protocol
				binding.Properties.Item("bindingInformation").Value = b.binding_information
				bindings.AddElement binding
			end

			ensure_pool

			app = Application.new
			app.site = @name
			app.path = "/"
			app.physical_path = @physical_path
			app.preloader = @preloader
			app.create

			#application = element.Collection.CreateNewElement("application")
			#application.Properties.Item("path").Value = "/"
			#application.Properties.Item("applicationPool").Value = @application_pool
			#application.Properties.Item("enabledProtocols").Value = @enabledProtocols unless @enabledProtocols == nil
			#application.Properties.Item("serviceAutoStartEnabled").Value = @serviceAutoStartProvider != nil
			#application.Properties.Item("serviceAutoStartProvider").Value = @serviceAutoStartProvider unless @serviceAutoStartProvider == nil
			#element.Collection.AddElement application

			#virtual_directory = application.Collection.CreateNewElement("virtualDirectory")
			#virtual_directory.Properties.Item("path").Value = "/"
			#virtual_directory.Properties.Item("physicalPath").Value = @physical_path
			#application.Collection.AddElement(virtual_directory)

			section.Collection.AddElement(element)

			set_authentication_enabled @enable_anonymous_authentication, "anonymousAuthentication"
			set_authentication_enabled @enable_basic_authentication, "basicAuthentication"
			set_authentication_enabled @enable_windows_authentication, "windowsAuthentication"
		end
	end

private

  def set_authentication_enabled(value, type)
    unless value == nil
      s = m.get_config_section "system.webServer/security/authentication/" + type, "MACHINE/WEBROOT/APPHOST/" + @name
      s.Properties.Item("enabled").Value = value
    end
  end

  def ensure_pool
    @application_pool = @name if @application_pool == nil

    pool = ApplicationPool.get @name

    if pool == nil
      pool = ApplicationPool.new
      pool.name = @application_pool
      pool.create
    end

  end

  def get_bindings
    @bindings = [BindingInformation.new] if @bindings == nil
    @bindings
  end

  def self.get(name, m = WIN32OLE.new("Microsoft.ApplicationHost.WritableAdminManager"))
    s = m.GetAdminSection("system.applicationHost/sites", "MACHINE/WEBROOT/APPHOST") 
    s.Collection.Count.times do |i|
      p = s.Collection.Item i
      return p if p.Properties.Item("name").Value == name
    end
    nil
  end
end
