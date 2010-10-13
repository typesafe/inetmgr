require 'spec_env'

describe "When adding an Application to a site" do
	
	before(:all) do

		configure do |cfg|
			site = cfg.get_sites[0]
			@app_name = "/#{generate_random_name}"
			site.applications.add do|a|
				a.path = @app_name
				a.virtual_directories.add do |vd|
					vd.path = @app_name
					vd.physicalPath = "D:\\"
				end
			end
		end

		configure do |cfg|
			@site = cfg.get_sites[0]
			@app = @site.applications.find {|a| a.path == @app_name}
		end
	end

	it "the app should be added" do
		@app.should_not be_nil
	end

	it "the app should contain the associated virtual directory" do
		@app.virtual_directories.size.should == 1
	end

	it "the virtual directory physical path should be set" do
		@app.virtual_directories[0].physicalPath.should == "D:\\"
	end

end

