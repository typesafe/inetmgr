require File.join(File.expand_path(File.dirname(__FILE__)), 'process_model.rb')
require File.join(File.expand_path(File.dirname(__FILE__)), 'recycling.rb')

class ApplicationPool < IisObject

	# prop :managed_runtime_version,   :managedRuntimeVersion
	# prop :pass_anonymous_token, :passAnonymousToken
	# prop :queue_length, :queueLength

	prop :auto_start,        :autoStart,              lambda { |a| a == true ? "true" : "false" },            lambda {|value| value == "true" }
	prop :classic_pipeline,  :managedPipelineMode,    lambda { |a| a == true ? 1 : 0 },                       lambda {|value| value.to_i == 1 }
	prop :enable_32bit,      :enable32BitAppOnWin64
	prop :always_running,    :startMode,              lambda { |a| a == true ? "AlwaysRunning" : "OnDemand" },lambda {|value| value.to_i == 1 }
	
    child :process_model, :processModel, ProcessModel
    child :recycling, :recycling, Recycling 

end

