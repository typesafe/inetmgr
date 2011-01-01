require 'rspec'
require 'test/unit'
require 'uuid'
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/inetmgr"))

module RSpecExtensions

	def configure(apply_changes = true)
		cfg = IisConfiguration.new
		yield cfg
	    cfg.apply_changes if apply_changes
	end

    def generate_random_name
	    UUID.generate(:compact).to_s
    end

end

RSpec::Runner.configure do |config|
  config.include RSpecExtensions
end