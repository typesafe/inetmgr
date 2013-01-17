require './spec_env.rb'

describe "When getting a sites connection strings" do

	before(:all) do
		iis_cfg = Inetmgr::IisConfiguration.new
		site = iis_cfg.get_sites.find { |s| s.name= 'thuis.jolena.be' }
		site.configure do |site_cfg|
			@validation_settings = site_cfg.get_validation_settings
		end
	end

	it "the settings should be returned" do
		puts @validation_settings.validate_integrated_mode_configuration
		@validation_settings.validate_integrated_mode_configuration.should_not == nil
	end

end
