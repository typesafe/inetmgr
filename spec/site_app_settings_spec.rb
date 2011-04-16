require './spec_env.rb'

describe "When getting a sites connection strings" do

	before(:all) do
		iis_cfg = IisConfiguration.new
		site = iis_cfg.get_sites.find { |s| s.name= 'thuis.jolena.be' }
		site.configure do |site_cfg|
			@app_settings = site_cfg.get_connection_strings
		end
	end

	it "the settings should be returned" do
		@app_settings.size.should == 1
	end

end

describe "When changing an app setting" do

	before(:all) do
		@iis_cfg = IisConfiguration.new
		site = @iis_cfg.get_sites.find { |s| s.name= 'thuis.jolena.be' }
		site.configure do |site_cfg|
			@previous = site_cfg.get_app_settings[0].value
			site_cfg.get_app_settings[0].value = "foo"
		end
	end

	it "the settings should be persisted" do
		site = @iis_cfg.get_sites.find { |s| s.name= 'thuis.jolena.be' }
		site.configure do |site_cfg|
			site_cfg.get_app_settings[0].value.should == "foo"
			site_cfg.get_app_settings[0].value = @previous
		end
	end

end

describe "When adding an app setting" do

	before(:all) do
		@iis_cfg = IisConfiguration.new
		site = @iis_cfg.get_sites.find { |s| s.name= 'thuis.jolena.be' }
		site.configure do |site_cfg|
			@previous = site_cfg.get_app_settings.size
			site_cfg.get_app_settings.add do |setting|
				setting.key = generate_random_name()
				setting.value = "bar"
			end
		end
	end

	it "the settings should be persisted" do
		site = @iis_cfg.get_sites.find { |s| s.name= 'thuis.jolena.be' }
		site.configure do |site_cfg|
			site_cfg.get_app_settings.size.should == (@previous + 1)
		end
	end

end