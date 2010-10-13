require 'spec_env'

describe "When getting the configured sites" do

	before(:all) do
		configure do |cfg|
			@sites = cfg.get_sites
		end
	end

	it "at least one item should be returned" do
		@sites.size > 1
	end

end

describe "When adding a new site" do

	before(:all) do
		configure do |cfg|
			@sites = cfg.get_sites
			@site = @sites.add { |s| s.name = generate_random_name }
		end
	end

	it "the site should be created" do
		@site.should_not be_nil
	end

	it "the site should have the highest id" do
		@site.id.should == @sites.size
	end

end
