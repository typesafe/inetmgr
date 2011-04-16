require 'spec_env'

describe "When adding a new application pool" do

	before(:all) do
		@pools = IisConfiguration.new.get_application_pools
		@before_count = @pools.size
		@pool = @pools.add do |p|
			p.name = "tralala"
		end
	end

	it "it should be present in the application pool collection" do
		@pools.size.should == @before_count + 1
	end

	it "the auto_start value should default to false" do
		@pool.auto_start.should == false
	end

	# TODO: fix this -> it depends on the defaults in the config
	it "the managed_runtime_version value should default to 'v2.0'" do
		@pool.managed_runtime_version.should == "v2.0"
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

describe "When updating application pool" do

	before(:all) do

		@name = generate_random_name()

		configure do |cfg|

			pool = cfg.get_application_pools.add { |p| p.name = @name } # defaults

			pool.auto_start = true
			pool.managed_runtime_version = "v4.0"
			pool.classic_pipeline = true
			pool.enable_32bit = true
			pool.always_running = true

		end

		configure do |cfg|
			@pool = cfg.get_application_pools.find { |p| p.name == @name }
		end
		
	end

	it "the name should be changed" do
		@pool.name.should == @name
	end

	it "the auto_start value should be changed" do
		@pool.auto_start.should == false
	end

	it "the managed_runtime_version value should be changed" do
		@pool.managed_runtime_version.should == "v4.0"
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

describe "When updating an application pool's proces model" do

	before(:all) do

		@name = generate_random_name()

		configure do |cfg|

			pool = cfg.get_application_pools.add { |p| p.name = @name } # defaults

			m = pool.process_model
			m.logon_type = :service
			m.identity_type = :network_service
		end

		configure do |cfg|
			pool = cfg.get_application_pools.find { |p| p.name == @name }
			@proces_model = pool.process_model
		end

	end

	it "the logon type should be changed" do
		@proces_model.logon_type.should == :service
	end

	it "the identity type should be changed" do
		@proces_model.identity_type.should == :network_service
	end

end