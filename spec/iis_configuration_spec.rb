require 'spec_env'

describe "When getting the configured application pools" do

	before(:all) do
		configure do |cfg|
			@pools = cfg.get_application_pools
		end
	end

	it "at least one item should be returned" do
		@pools.size > 1
	end
	
end

describe "When rolling back configuration changes" do

	before(:all) do
		configure false do |cfg|
			cfg.get_application_pools.add do |p|
				p.name = "foobar"
			end
		end
		configure false do |cfg|
			@non_existing_pool = cfg.get_application_pools.find { |p| p.name == "foobar" }
		end
	end

	it "the changes should not be applied" do
		@non_existing_pool.should be_nil
	end

end

