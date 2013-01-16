module Inetmgr
  # Specifies security, performance, health, and reliability features of application pools.
class ProcessModel < IisObject

	Identity_type_map = [:system, :local_service, :network_service, :specific_user, :application_pool_identity]

	##
	# Specifies the logon type for the process identity.
	# - :batch indicates that the application pool identity should logon as a batch user.
	# - :service indicates that the application pool identity should logon as a service.

	prop :logon_type, :logonType, lambda {|value| value == :batch ? 0 : 1 }, lambda { |a| a == 0 ? :batch : :service }

	prop :identity_type, :identityType, lambda {|value| Identity_type_map.index(value)}, lambda { |a| Identity_type_map[a] }
	prop :user_name, :userName
	#prop :password
	prop :load_user_profile, :loadUserProfile

end

end