
class ProcessModel < IisObject

end

class PeriodicRestart < IisObject
	children :schedule, :schedule, IisObject
end

class Recycling < IisObject
	child :periodic_restart, :periodicRestart, PeriodicRestart
end 

class ApplicationPool < IisObject
	
	prop :auto_start,        :autoStart,              Proc.new { |a| a == true ? "true" : "false" },            Proc.new {|value| value == "true" }
	prop :runtime_version,   :managedRuntimeVersion,  Proc.new { |a| a },                                       Proc.new {|value| value }
	prop :classic_pipeline,  :managedPipelineMode,    Proc.new { |a| a == true ? 1 : 0 },                       Proc.new {|value| value.to_i == 1 }
	prop :enable_32bit,      :enable32BitAppOnWin64,  Proc.new { |a| a },                                       Proc.new {|value| value }
	prop :always_running,    :startMode,              Proc.new { |a| a == true ? "AlwaysRunning" : "OnDemand" },Proc.new {|value| value.to_i == 1 }

    child :process_model, :processModel, ProcessModel
    child :recycling, :recycling, Recycling 

end

