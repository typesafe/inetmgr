
require File.join(File.expand_path(File.dirname(__FILE__)), '../lib/string.rb')

describe "When converting underscored symbols to camel case" do

	before(:each) do
		@values = ['foo_bar']
		@results = []
		@values.each {|v| @results << v.to_camel_case }
	end

  it "all samples shoud be converted ok" do
    @results[0].should == 'fooBar'
  end
end

