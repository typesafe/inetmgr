# Represents an IIS configuration element. Serves as the base class for all
# IIS artifacts like Site, Application and VirtualDirectory.
class IisObject

	def initialize element
		@element = element
	end

	# Creates a property with the specified name.
	#
	# ==== Parameters
	# * <tt>name</tt> - The name of the property to create
	# * <tt>actual_name</tt> - Optional, The actual name of the attribute or
	# element in the IIS configuration schema.
	# * <tt>setter</tt> - Optional, a lambda or proc to convert the property
	# value to a value in the IIS configuration schema.
	# * <tt>reader</tt> - Optional, a lambda or proc to convert the IIS
	# configuration value to the desired property value.
	def self.prop name, actual_name, setter = lambda { |v| v }, reader = lambda { |v| v }
		define_method(name.to_s) do
		  reader.call(@element.Properties.Item(actual_name.to_s).Value)
		end

		define_method("#{name.to_s}=") do |val|
		  @element.Properties.Item(actual_name.to_s).Value = setter.call(val)
		end
	end

	# Creates a collection property with the specified name.
	#
	# ==== Parameters
	# * <tt>name</tt> - The name of the property to create
	# * <tt>type</tt> - The collection's item type.
	def self.collection name, item_name, type
		define_method(name.to_s) do
			IisObjectCollection.new @element.Collection, item_name.to_s, type
		end
	end

	# Creates a collection property with the specified name.
	#
	# ==== Parameters
	# * <tt>name</tt> - The name of the property to create
	# * <tt>item_name</tt> - The name of the element in the configuration schema.
	# * <tt>type</tt> - The collection's item type.
	def self.children name, item_name, type
		define_method(name.to_s) do
			IisObjectCollection.new @element.ChildElements.Item(name.to_s).Collection, item_name.to_s, type
		end
	end

	def self.child name, element_name, type
		define_method(name.to_s) do
			type.new @element.ChildElements.Item(element_name.to_s)
		end
	end

	def invoke_method name
		method = @element.Methods.Item(name.to_s).CreateInstance()
		
		# TODO: if block_given? change method_missing to change this:
		# method.Input.Properties.Item("key").Value = value
		# in to this:
		# method.key = value

		yield method if block_given?
		method.Execute()
	end

private

	def method_missing(symbol, *args)
		name = symbol.to_s.to_camel_case
		if (/=$/.match(name))
			
			@element.Properties.Item(name.sub(/=$/, '')).Value = args[0]
		else
			@element.Properties.Item(name).Value
		end
	rescue WIN32OLERuntimeError
		raise "property '#{symbol}' -> #{$!}"
	end

end

