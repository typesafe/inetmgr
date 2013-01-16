require './spec_env.rb'

describe "When getting the configured sites" do

	before(:all) do
		configure do |cfg|
			@sites = cfg.get_sites
		end
	end

	it "at least one item should be returned" do
		@sites.size.should > 1
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

  context "When the site ids in IIS are not in ascending order" do
    before(:all) do
      @site2 = @sites.add { |s| s.name = generate_random_name }
      @sites.remove(@sites.find_index { |site| site.id == @site.id })
    end

    it "the new site id should be one higher then the highest existing site id" do
      ids = []
      @sites.each { |s| ids << s.id }
      max_id = ids.max

      @site3 = @sites.add { |s| s.name = generate_random_name }

      @site3.id.should == max_id + 1
    end
  end
end
