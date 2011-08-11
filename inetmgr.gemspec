require 'rubygems'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|

    s.name       = "inetmgr"
    s.version    = "0.5.0"
    s.summary    = "A library for managing IIS configuration settings."
    s.description = "inetmgr allows you to inspect/configure IIS configuration sections and elements."

	s.required_ruby_version     = '>= 1.9.2'
	s.required_rubygems_version = ">= 1.3.6"
	
	s.author     = "Gino Heyman"
    s.email      = "gino.heyman@gmail.com"
    s.homepage   = "http://typesafe.be/inetmgr/"

    s.files      = FileList["**/**/*"].to_a
    s.require_path      = "lib"
    
end
