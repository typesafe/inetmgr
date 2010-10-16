
class BindingInformation < IisObject

	#prop :protocol
	prop :binding_information, :bindingInformation
	prop :ds_mapper_enabled?, :isDsMapperEnabled

	def add_ssl_certificate thumprint, store
		invoke_method("AddSslCertificate") do |method|
			method.Input.Properties.Item("certificateHash").Value = thumprint
			method.Input.Properties.Item("certificateStoreName").Value = store
		end
	end

	def remove_ssl_certificate
		invoke_method("RemoveSslCertificate")
	end

	def enable_ds_mapper
		invoke_method("EnableDsMapper")
	end

	def disable_ds_mapper
		invoke_method("DisableDsMapper")
	end
end