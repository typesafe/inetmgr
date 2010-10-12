
class IisObject

	def initialize element
		@element = element
	end

	def self.prop name, actual_name, setter = Proc.new { |v| v }, reader = Proc.new { |v| v }
		define_method(name.to_s) do
		  reader.call(get_element_prop(actual_name.to_s))
		end

		define_method("#{name.to_s}=") do |val|
		  set_element_prop actual_name.to_s, setter.call(val)
		end
	end

	def self.collection name, item_name, type
		define_method(name.to_s) do
			IisObjectCollection.new @element.Collection, item_name.to_s, type
		end
	end

	def self.children name, item_name, type
		define_method(name.to_s) do
			IisObjectCollection.new @element.ChildElements.Item(name.to_s).Collection, item_name.to_s, type
		end
	end

	def element
		@element
	end

private

	def method_missing(symbol, *args)
		name = symbol.to_s
		if (/=$/.match(name))
			@element.Properties.Item(name.sub(/=$/, '')).Value = args[0]
		else
			@element.Properties.Item(name).Value
		end
	end

	def set_element_prop(name, val)
		@element.set name, val
	end

	def get_element_prop(name)
		@element.get name
	end

end

