require File.join(File.expand_path(File.dirname(__FILE__)), 'site_limit.rb')
require File.join(File.expand_path(File.dirname(__FILE__)), 'site_logfile.rb')
require File.join(File.expand_path(File.dirname(__FILE__)), 'binding_information.rb')
require File.join(File.expand_path(File.dirname(__FILE__)), 'application.rb')

class Site < IisObject

	# name
	# id

	# autoStart getting returns TrueClass from WIN32OLE
	prop :auto_start, :serverAutoStart, lambda { |a| a == true ? "true" : "false" }, lambda {|value| value == true || value == "true" }

	collection :applications, :application, Application

    children :bindings, :binding, BindingInformation

	child :limits, :limits, SiteLimit
	child :log_file, :logFile, SiteLogFile

	def configure
		cfg = SiteConfiguration.new name
		yield cfg
		cfg.apply_changes
	end

end
