require 'inetmgr/iis_object/site.rb'
require 'inetmgr/iis_object/application_pool.rb'
require 'inetmgr/iis_object/auto_start_provider.rb'

module Inetmgr
# Represents the local IIS configuration settings (meta base).
class IisConfiguration < Configuration

	def initialize(server = nil)
		super "MACHINE/WEBROOT/APPHOST", server
	end

	def self.configure
		cfg = IisConfiguration.new
		yield cfg
		cfg.apply_changes
	end
	
	# Gets all configured web sites.
    def get_sites
		s = get_admin_section "system.applicationHost/sites"
	    IisObjectCollection.new s.Collection, :site, Site, lambda { |site| site.id = s.Collection.Count + 1 }
    end

	# Gets all configure application pools.
    def get_application_pools
		s = get_admin_section "system.applicationHost/applicationPools"
		IisObjectCollection.new s.Collection, :add, ApplicationPool
    end

	# Gets all configured service auto start providers.
	def get_auto_start_providers
		s = get_admin_section "system.applicationHost/serviceAutoStartProviders"
		IisObjectCollection.new s.Collection, :add, AutoStartProvider
	end

end
end