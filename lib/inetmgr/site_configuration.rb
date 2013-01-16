module Inetmgr

class SiteConfiguration < Configuration

	def initialize(name, server = nil)
		super "MACHINE/WEBROOT/APPHOST/#{name}", server
	end

	def get_app_settings
		get_collection "appSettings"
	end

	def get_connection_strings
		get_collection "connectionStrings"
	end

	def get_validation_settings
		IisObject.new get_admin_section("system.webServer/validation")
	end

	def get_static_content_settings
		IisObject.new get_admin_section("system.webServer/staticContent")
	end

	def get_service_model_settings
		IisObject.new get_admin_section("system.serviceModel")
	end

private

	def get_collection(name)
		IisObjectCollection.new get_admin_section(name).Collection, :add, IisObject
	end

end

end