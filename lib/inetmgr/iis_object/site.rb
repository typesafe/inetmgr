require File.join(File.expand_path(File.dirname(__FILE__)), 'site_limit.rb')
require File.join(File.expand_path(File.dirname(__FILE__)), 'binding_information.rb')
require File.join(File.expand_path(File.dirname(__FILE__)), 'application.rb')

class Site < IisObject

	# name
	# id

	prop :auto_start, :serverAutoStart

	collection :applications, :application, Application

    children :bindings, :binding, BindingInformation

	child :limits, :limits, SiteLimit

	def configure
		cfg = SiteConfiguration.new name
		yield cfg
		cfg.apply_changes
	end

end
