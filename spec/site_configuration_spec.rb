require './spec_env.rb'

describe "When getting a sites connection strings" do

	before(:all) do
		iis_cfg = Inetmgr::IisConfiguration.new
		site = iis_cfg.get_sites.find { |s| s.name= 'thuis.jolena.be' }
		site.configure do |site_cfg|
			@validation_settings = site_cfg.get_validation_settings
			@static_content_settings = site_cfg.get_static_content_settings
			
		end
	end

	it "the validation settings should be returned" do
		@validation_settings.should_not == nil
	end

	it "the static content settings should be returned" do
		@static_content_settings.should_not == nil
	end


end
