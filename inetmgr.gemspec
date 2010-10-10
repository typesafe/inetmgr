require 'rubygems'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
    s.name       = "inetmgr"
    s.version    = "0.2.0"
    s.author     = "Gino Heyman"
    s.email      = "gino.heyman@gmail.com"
    s.homepage   = "http://typesafe.be/inetmgr"
    s.platform   = 'mswin32'
    s.summary    = "A library (and rake task suite) for managing IIS configuration settings."
    s.description = "A library (and rake task suite) for managing IIS configuration settings."
    s.files      = FileList["{lib}/**/*"].to_a
    s.require_path      = "lib"
    
    #s.add_dependency 'win32ole'
end
