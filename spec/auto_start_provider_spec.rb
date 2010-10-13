require 'spec_env'

describe "When adding an auto start provider" do

	before(:all) do
		configure do |cfg|
			@name = generate_random_name
			@type = generate_random_name
			@provider = cfg.get_auto_start_providers.add { |p| p.name = @name; p.type = @type }
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
