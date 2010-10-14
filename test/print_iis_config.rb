require '..\lib\inetmgr.rb'

cfg = IisConfiguration.new

sites = cfg.get_sites
pools = cfg.get_application_pools

pools.each do |p|
	puts "\r\nPOOL: #{p.name}"
	puts "----"
	puts " - auto_start:\t #{p.auto_start}"
	puts " - always_running:\t #{p.always_running}"
	puts " - CLRConfigFile:\t #{p.CLRConfigFile}"	# not yet mapped
	puts " - enable_32bit:\t #{p.enable_32bit}"
	puts " - enableConfigurationOverride:\t #{p.enableConfigurationOverride}"	# not yet mapped
	puts " - classic_pipeline:\t #{p.classic_pipeline}"
	puts " - runtime_version:\t #{p.runtime_version}"
	puts " - passAnonymousToken:\t #{p.passAnonymousToken}"

	puts " - process_model:"
	puts "    - identityType: #{p.process_model.identityType}"
	puts "    - idleTimeout: #{p.process_model.idleTimeout}"
	puts "    - logon_type: #{p.process_model.logon_type}"

	puts " - recycling:"
	puts "    - logEventOnRecycle: #{p.recycling.logEventOnRecycle}"
	puts "    - periodic_restart.schedulecount: #{p.recycling.periodic_restart.schedule.size}"

end

sites.each do |s|

	puts "SITE: #{s.name} #{s.bindings.size}"

	s.bindings.each do |b|
		puts "binding: #{b.protocol} - #{b.binding_information}"
	end

	s.applications.each do |a|
		puts "    app: #{a.path}"
		a.virtual_directories.each do |d|
			puts "       dir: #{d.path}"
		end
	end

end


