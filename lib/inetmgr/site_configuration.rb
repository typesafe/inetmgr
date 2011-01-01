
class SiteConfiguration < Configuration

	def initialize(name)
		super "MACHINE/WEBROOT/APPHOST/#{name}"
	end

	def get_app_settings
		s = get_config_section "appSettings"
		IisObjectCollection.new s.Collection, :add, IisObject
	end

end
