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
