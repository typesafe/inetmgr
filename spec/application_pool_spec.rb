require 'spec_env'

describe "When getting an application pool by name" do

	before(:all) do
		configure do |cfg|
			cfg = IisConfiguration.new
			name = cfg.get_application_pools[0].name

			@pool = cfg.get_application_pool name
		end
	end

	it "it should be returned" do
		@pool.should_not be_nil
	end

end

describe "When getting an application pool that does not exist" do

	before(:all) do
		configure do |cfg|
			@pool = cfg.get_application_pool "mqklsjdmflkqsjdmfkljname"
		end
	end

	it "nil should be returned" do
		@pool.should be_nil
	end

end

describe "When adding a new application pool" do

	before(:all) do
		configure do |cfg|
			@name = "foobar"
			cfg.add_application_pool @name

			@pool = cfg.get_application_pool(@name)
		end
	end

	it "it should be present in the application pool collection" do
		@pool.should_not be_nil
	end

	it "the auto_start value should default to false" do
		@pool.auto_start.should == false
	end

	# TODO: fix this -> it depends on the defaults in the config
	it "the runtime_version value should default to 'v2.0'" do
		@pool.runtime_version.should == "v2.0"
	end

	it "the classic_pipeline value should default to false" do
		@pool.classic_pipeline.should == false
	end

	it "the enable_32bit value should default to false" do
		@pool.enable_32bit.should == false
	end

	it "the always_running value should default to false" do
		@pool.always_running.should == false
	end
end

describe "When updating an application pool" do

	before(:all) do

		configure do |cfg|
			@name = generate_random_name()
			cfg.add_application_pool @name

			pool = cfg.get_application_pool(@name)
			puts pool.startMode

			pool.name = "new name"
			pool.auto_start = true
			pool.runtime_version = "v4.0"

			pool.classic_pipeline = true
			pool.enable_32bit = true
			pool.always_running = true

			@pool = cfg.get_application_pool "new name"
		end
	end

	it "the name should be changed" do
		@pool.name.should == "new name"
	end

	it "the auto_start value should be changed" do
		@pool.auto_start.should == false
	end

	it "the runtime_version value should be changed" do
		@pool.runtime_version.should == "v4.0"
	end

	it "the classic_pipeline value should be changed" do
		@pool.classic_pipeline.should == true
	end

	it "the enable_32bit value should be changed" do
		@pool.enable_32bit.should == true
	end

	it "the always_running value should be changed" do
		puts @pool.startMode
		@pool.always_running.should == true
	end

end
