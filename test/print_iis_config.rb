require '../lib/inetmgr.rb'

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
	puts " - managed_runtime_version:\t #{p.managed_runtime_version}"
	puts " - passAnonymousToken:\t #{p.passAnonymousToken}"

	puts "\r\n - process_model:"
	puts "    - identity_type: #{p.process_model.identity_type}"
	puts "    - idleTimeout: #{p.process_model.idleTimeout}"
	puts "    - logon_type: #{p.process_model.logon_type}"
	puts "    - user_name '#{p.process_model.user_name}'"
	puts "    - password '#{p.process_model.password}'"
	puts "    - load_user_profile: #{p.process_model.load_user_profile}"
	
	puts "\r\n - recycling:"
	puts "    - logEventOnRecycle: #{p.recycling.logEventOnRecycle}"
	puts "    - periodic_restart.schedulecount: #{p.recycling.periodic_restart.schedule.size}"
	puts "----------------------------"

end

sites.each do |s|

	puts "SITE: #{s.name} #{s.bindings.size}"
	puts "----"
	
	s.bindings.each do |b|
		puts " - binding: #{b.protocol}|#{b.binding_information}"
	end

	puts " - limits: bandwitdth: #{s.limits.max_bandwidth}, connections: #{s.limits.max_connections}, connection timout: #{s.limits.connection_timeout}"
	
	s.applications.each do |a|
		puts " - app: #{a.path}"
		a.virtual_directories.each do |d|
			puts "    - dir: #{d.path} -> #{d.physical_path}"
		end
	end
	puts "----------------------------"
	
end


