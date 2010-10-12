require '..\lib\inetmgr.rb'

cfg = IisConfiguration.new

sites = cfg.get_sites

sites.each do|s|
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
