require File.join(File.expand_path(File.dirname(__FILE__)), 'periodic_restart.rb')

module Inetmgr
  class Recycling < IisObject
	child :periodic_restart, :periodicRestart, PeriodicRestart
end
  
end