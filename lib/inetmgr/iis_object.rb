
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

private

  def method_missing(symbol, *args)
    name = symbol.to_s
    if (/=$/.match(name))
		    @element.set(name.sub(/=$/, ''), args[0])
    else
      @element.get name
    end
  end

	def set_element_prop(name, val)
		@element.set name, val
	end

	def get_element_prop(name)
		@element.get name
	end

end
