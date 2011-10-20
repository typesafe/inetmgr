require '../lib/inetmgr.rb'

IisConfiguration.configure do |cfg|
	cfg.get_sites.add do |site|
		site.name = "Contoso"
		site.auto_start = true
		site.bindings.add do |b|
			b.protocol = "http"
			b.binding_information = "*:80:www.contoso.com"
		end

		site.bindings.add do |b|
			b.protocol = "https"
			b.binding_information = "*:443:"
			b.add_ssl_certificate "e2564766bad7ebec8cf6899caa2a27c6391c4f19", "MY"
		end

		site.applications.add do |app|
			app.path = "/"
			app.virtual_directories.add do |dir|
				dir.path = "/"
				dir.physical_path = "D:\\temp"
			end
		end

		site.log_file.directory = 'D:\logs'
		site.log_file.period = 'Hourly'
		site.log_file.format = 'IIS'
		site.log_file.log_ext_file_flags = 'Date, Time, ClientIP, Method, HttpStatus, BytesSent, TimeTaken, Referer, UserAgent'
	end
end
