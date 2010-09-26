require '../lib/inetmgr'

task :default => [:app]

task :all => [:provider ]

auto_start_provider :provider do |p|
	p.name = "fooobar"
	p.type = "foo.bar, foo"
end

application :app do |a|
	a.site = "foobar"
	a.path = "/application"
	a.physical_path = "d:\\temp"
	a.preloader = "preloader"
end

virtual_directory :dir do |dir|
	dir.path = "/dir"
	dir.physical_path = "d:\\temp"
	dir.site = "foobar"
end

applicationpool :pool do |pool|
	pool.name = "bla"
	pool.auto_start = false
	pool.runtime_version = "v4.0"
	pool.pipeline_mode = "Integrated"
	pool.always_running = true
	pool.enable_32bit = false   
end

site :site do |site|
	site.name = "fooobar"
	site.physical_path = "D:\\temp"
	site.bindings = [ BindingInformation.new("*:80:www.foobar.com", "http") ]
	#site.auto_start = false
	#site.application_pool = "foobar"
	#site.enabledProtocols = "http"
  
	#site.preloader = nil
	#site.enable_anonymous_authentication = true
	#site.enable_basic_authentication = true
	#site.enable_windows_authentication = true
end


