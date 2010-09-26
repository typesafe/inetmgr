require 'win32ole'

class IisObject
  attr_reader :admin_manager

  def configure(&block)
    @admin_manager = WIN32OLE.new "Microsoft.ApplicationHost.WritableAdminManager"
    @admin_manager.CommitPath = "MACHINE/WEBROOT/APPHOST";
    def @admin_manager.get_config_section section_name, path = "MACHINE/WEBROOT/APPHOST"
      self.GetAdminSection(section_name, path)
    end

    block.call @admin_manager
    @admin_manager.CommitChanges
  end

end

