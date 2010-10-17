
class ProcessModel < IisObject

	Identity_type_map = [:system, :local_service, :network_service, :specific_user, :application_pool_identity]

	prop :logon_type, :logonType, lambda {|value| value == :batch ? 0 : 1 }, lambda { |a| a == 0 ? :batch : :service }
	prop :identity_type, :identityType, lambda {|value| Identity_type_map.index(value)}, lambda { |a| Identity_type_map[a] }
	prop :user_name, :userName
	#prop :password
	prop :load_user_profile, :loadUserProfile
	
end

class PeriodicRestart < IisObject
	children :schedule, :schedule, IisObject
end

class Recycling < IisObject
	child :periodic_restart, :periodicRestart, PeriodicRestart
end 

class ApplicationPool < IisObject
	


	prop :auto_start,        :autoStart,              lambda { |a| a == true ? "true" : "false" },            lambda {|value| value == "true" }
	prop :runtime_version,   :managedRuntimeVersion
	prop :classic_pipeline,  :managedPipelineMode,    lambda { |a| a == true ? 1 : 0 },                       lambda {|value| value.to_i == 1 }
	prop :enable_32bit,      :enable32BitAppOnWin64
	prop :always_running,    :startMode,              lambda { |a| a == true ? "AlwaysRunning" : "OnDemand" },lambda {|value| value.to_i == 1 }
	prop :pass_anonymous_token, :passAnonymousToken
	prop :queue_length, :queueLength

    child :process_model, :processModel, ProcessModel
    child :recycling, :recycling, Recycling 

end



