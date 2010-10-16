require 'spec_env'

describe "When adding an SSL certificate" do
  
	before(:all) do
		configure false do |cfg|
			@binding = cfg.get_sites[0].bindings[0]
			@binding.add_ssl_certificate "e2564766bad7ebec8cf6899caa2a27c6391c4f19", "MY"
		end
	end

  it "the cert hash should be set" do
	  @binding.certificateHash.downcase.should == "e2564766bad7ebec8cf6899caa2a27c6391c4f19"
  end

	 it "the cert store name should be set" do
    @binding.certificateStoreName.should == "MY"
  end

end

