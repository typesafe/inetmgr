require File.join(File.expand_path(File.dirname(__FILE__)), 'periodic_restart.rb')

class Recycling < IisObject
	child :periodic_restart, :periodicRestart, PeriodicRestart
end
