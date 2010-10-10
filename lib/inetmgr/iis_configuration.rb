
class IisConfiguration
	
	def initialize
		@admin_manager = WIN32OLE.new "Microsoft.ApplicationHost.WritableAdminManager"
		@admin_manager.CommitPath = "MACHINE/WEBROOT/APPHOST";
	end

    def apply_changes
	    @admin_manager.CommitChanges
    end

    def get_site name
		e = get_sites_section.get_item_with_name name
	    return Site.new(e) unless e.nil?
	    nil
    end

    def add_site name
	    section = get_sites_section
      e = section.add_element("site") do |e|
			e.set "name", name
			e.set "id", section.count + 1
		end
        s = Site.new (e)
        s.add_application "/"
        s
    end

    def get_sites
      sites = []
      get_sites_section.for_each do |p|
        sites << Site.new(p)
      end
      sites
    end

    def get_application_pools
	    pools = []
        get_application_pools_section.for_each do |p|
			pools << ApplicationPool.new(p)
        end
        pools
    end

	def get_application_pool name
		e = get_application_pools_section.get_item_with_name name
	    return ApplicationPool.new(e) unless e.nil?
	    nil
	end

	def add_application_pool name
		e = get_application_pools_section.add_collection_element(name)
		ApplicationPool.new(e)
	end

	def get_auto_start_providers
		asps = []
        get_auto_start_providers_section.for_each do |p|
			asps << AutoStartProvider.new(p)
        end
        asps
	end

	def add_auto_start_provider(name, type)
		asp = get_auto_start_providers_section.add_collection_element(name) do |e|
		end
	    p = AutoStartProvider.new(asp)
	    p.type = type
	    p
	end
	
private

	def get_application_pools_section
		get_config_section "system.applicationHost/applicationPools"
	end

	def get_sites_section
	   get_config_section "system.applicationHost/sites"
   end

	def get_auto_start_providers_section
	   get_config_section "system.applicationHost/serviceAutoStartProviders"
	end
	
	def get_config_section section_name, path = "MACHINE/WEBROOT/APPHOST"
		@admin_manager.GetAdminSection(section_name, path)
	end

end