
# Represents the local IIS configuration settings (meta base)
class IisConfiguration
	
	def initialize
		@admin_manager = WIN32OLE.new "Microsoft.ApplicationHost.WritableAdminManager"
		@admin_manager.CommitPath = "MACHINE/WEBROOT/APPHOST";
	end

	# applies/commits all changes made since the creation of the
	# IisConfiguration instance or the last time this method was called.
    def apply_changes
	    @admin_manager.CommitChanges
    end

	# Gets all configured web sites.
    def get_sites
		s = get_config_section "system.applicationHost/sites"
	    IisObjectCollection.new s.Collection, :site, Site, lambda { |site| site.id = s.Collection.Count + 1 }
    end

	# Gets all configure application pools.
    def get_application_pools
		s = get_config_section "system.applicationHost/applicationPools"
		IisObjectCollection.new s.Collection, :add, ApplicationPool
    end

	# Gets all configured service auto start providers.
	def get_auto_start_providers
		s = get_config_section "system.applicationHost/serviceAutoStartProviders"
		IisObjectCollection.new s.Collection, :add, AutoStartProvider
	end
	
private

	def get_config_section section_name, path = "MACHINE/WEBROOT/APPHOST"
		@admin_manager.GetAdminSection(section_name, path)
	end

end