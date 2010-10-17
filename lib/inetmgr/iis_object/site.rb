
class SiteLimit < IisObject

	prop :max_bandwidth, :maxBandwidth
	prop :max_connections, :maxConnections
	prop :connection_timeout, :connectionTimeout

end

class Site < IisObject

	#name
	#id

	prop :auto_start, :serverAutoStart

	collection :applications, :application, Application

    children :bindings, :binding, BindingInformation

	child :limits, :limits, SiteLimit
end
