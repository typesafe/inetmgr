require '..\lib\inetmgr.rb'

cfg = IisConfiguration.new

sites = cfg.get_sites
pools = cfg.get_application_pools

pools.each do |p|
	puts "POOL: #{p.name}"
	puts "----"

	puts " - process_model:"
	puts "    - identityType: #{p.process_model.identityType}"

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
