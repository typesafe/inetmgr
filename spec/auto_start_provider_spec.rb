require 'spec_env'

describe "When getting the configured auto start providers" do

	before(:all) do
		configure do |cfg|
			@list = cfg.get_auto_start_providers
		end
	end

	it "the list should not be empty" do
		@list.size.should > 0
	end

end

describe "When adding an auto start provider" do

	before(:all) do
		configure do |cfg|
      @name = generate_random_name
      @type = generate_random_name
			@provider = cfg.add_auto_start_provider @name, @type
		end
	end

	it "the provider should not be nil" do
		@provider.should_not be_nil
	end

	it "the provider name should be set" do
		@provider.name.should == @name
	end

	it "the provider type should be set" do
		@provider.type.should == @type
	end

end
