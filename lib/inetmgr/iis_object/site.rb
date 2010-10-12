
class Site < IisObject

	prop :auto_start,          :serverAutoStart

	collection :applications, :application, Application

    children :bindings, :binding, BindingInformation
    
end
