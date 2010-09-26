
class ApplicationPool < IisObject
	attr_accessor :name
	attr_accessor :auto_start
	attr_accessor :runtime_version
    attr_accessor :pipeline_mode
	attr_accessor :always_running
	attr_accessor :enable_32bit
  
	def create

		set_defaults

		configure do |m|
			section = m.get_config_section "system.applicationHost/applicationPools"
			element = section.Collection.CreateNewElement("add");
			element.Properties.Item("name").Value = @name
			element.Properties.Item("autoStart").Value = @auto_start ? true : false
			element.Properties.Item("managedRuntimeVersion").Value = @runtime_version
			element.Properties.Item("managedPipelineMode").Value = @pipeline_mode
			element.Properties.Item("enable32BitAppOnWin64").Value = "true" if @enable_32bit == true
			element.Properties.Item("startMode").Value = @always_running ? "AlwaysRunning" : "OnDemand"
			section.Collection.AddElement(element)
		end
	end

	def self.get(name, m = WIN32OLE.new("Microsoft.ApplicationHost.WritableAdminManager"))
		s = m.GetAdminSection("system.applicationHost/applicationPools", "MACHINE/WEBROOT/APPHOST")
		s.Collection.Count.times do |i|
			p = s.Collection.Item i
			puts p.Properties.Item("name").Value
			return p if p.Properties.Item("name").Value == name
		end
		nil
	end

    def set_defaults
		@runtime_version = "v4.0" if @runtime_version == nil
        @pipeline_mode = "Integrated" if @pipeline_mode == nil
    end
end