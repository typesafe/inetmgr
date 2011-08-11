
class Configuration 

	def initialize(path, server = nil)
		@admin_manager = WIN32OLE.new "Microsoft.ApplicationHost.WritableAdminManager", server
		@admin_manager.CommitPath = path;
	end

	# applies/commits all changes made since the creation of the
	# IisConfiguration instance or the last time this method was called.
	def apply_changes
		@admin_manager.CommitChanges
	end

private

	def get_admin_section(section_name)
		@admin_manager.GetAdminSection(section_name, @admin_manager.CommitPath)
	end

end
