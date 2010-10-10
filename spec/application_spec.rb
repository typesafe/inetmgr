require 'spec_env'
#
#describe "When adding an Application to a site" do
#	before(:all) do
#		@site = "foobar"
#		ap = Application.new
#		ap.site = @pool_name
#		ap.create
#		IisObject.commit
#
#		s = IIS.get_config_section "system.applicationHost/application"
#		@created_app = s.get_item_with_name(@pool_name)
#	end
#
#	it "the app should be created" do
#		@created_pool.should_not be_nil
#	end
#
#	it "the pool should default to no auto start" do
#		@created_pool.get('autoStart').should == false
#	end
#
#	it "the pool should  default to runtime version 4.0" do
#		@created_pool.get('managedRuntimeVersion').should == "v4.0"
#	end
#
#	it "the pool should default to integrated pipeline" do
#		@created_pool.get('managedPipelineMode').should == 0
#	end
#
#	it "the start mode should be set to OnDemand" do
#		@created_pool.get('startMode').should == 0
#	end
#end
