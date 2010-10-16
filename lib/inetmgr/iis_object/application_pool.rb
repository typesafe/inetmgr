
class ProcessModel < IisObject

	prop :logon_type, :logonType, lambda {|value| value == :batch ? 0 : 1 }, lambda { |a| a == 0 ? :batch : :service }
end

class PeriodicRestart < IisObject
	children :schedule, :schedule, IisObject
end

class Recycling < IisObject
	child :periodic_restart, :periodicRestart, PeriodicRestart
end 

class ApplicationPool < IisObject
	
	prop :auto_start,        :autoStart,              lambda { |a| a == true ? "true" : "false" },            lambda {|value| value == "true" }
	prop :runtime_version,   :managedRuntimeVersion,  lambda { |a| a },                                       lambda {|value| value }
	prop :classic_pipeline,  :managedPipelineMode,    lambda { |a| a == true ? 1 : 0 },                       lambda {|value| value.to_i == 1 }
	prop :enable_32bit,      :enable32BitAppOnWin64,  lambda { |a| a },                                       lambda {|value| value }
	prop :always_running,    :startMode,              lambda { |a| a == true ? "AlwaysRunning" : "OnDemand" },lambda {|value| value.to_i == 1 }

    child :process_model, :processModel, ProcessModel
    child :recycling, :recycling, Recycling 

end

