require './spec_env.rb'

describe "When getting a sites app settings" do

	before(:all) do
		iis_cfg = IisConfiguration.new
		site = iis_cfg.get_sites.find { |s| s.name= 'thuis.jolena.be' }
		site.configure do |site_cfg|
			@connection_strings = site_cfg.get_connection_strings
		end
	end

	it "the settings should be returned" do
		@connection_strings.size.should == 1
	end

end