
class IisObject

	def initialize element
		@element = element
	end

	def self.prop name, actual_name, setter = Proc.new { |v| v }, reader = Proc.new { |v| v }
		define_method(name.to_s) do
		  reader.call(@element.Properties.Item(actual_name.to_s).Value)
		end

		define_method("#{name.to_s}=") do |val|
		  @element.Properties.Item(actual_name.to_s).Value = setter.call(val)
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

	def self.child name, element_name, type
		define_method(name.to_s) do
			type.new @element.ChildElements.Item(element_name.to_s)
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

end

