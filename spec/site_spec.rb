require 'spec_env'

describe "When getting the configured sites" do

	before(:all) do
		configure do |cfg|
			@pools = cfg.get_sites
		end
	end

	it "at least one item should be returned" do
		@pools.size > 1
	end

end

describe "When getting a site by name" do

	before(:all) do
		configure do |cfg|
			name = cfg.get_sites[0].name
			@site = cfg.get_site name
		end
	end

	it "it should be returned" do
		@site.should_not be_nil
	end

end

describe "When getting a site's applications" do

	before(:all) do
		configure do |cfg|
			@site = cfg.get_sites[0]
			@apps = @site.get_applications
		end
	end

	it "at least one item should be returned" do
		@apps.size.should > 0
	end

end

describe "When getting a site's application by name" do

	before(:all) do
		configure do |cfg|
			@site = cfg.get_sites[0]
			path = @site.get_applications[0].path

			@app = @site.get_application path
		end
	end

	it "at least one item should be returned" do
		@app.should_not be_nil
	end

end

describe "When adding a new site" do

	before(:all) do
		configure do |cfg|
			@site = cfg.add_site "foosite"
		end
	end

	it "the site should be created" do
		@site.should_not be_nil
	end

	it "the site should have an application" do
		@site.get_applications.size.should > 0
	end
end

#describe "When adding a new virtual directory to a site" do
#
#
#	before(:all) do
#		configure do |cfg|
#		    @site = cfg.get_sites[0]
#		    @site.add_virtual_directory "virt"
#       end
#	end
#
#	it "it should be added" do
#		@site.should_not be_nil
#	end
#
#end