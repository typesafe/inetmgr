
class IisObjectCollection

	def initialize element, item_name, type
		@element = element
		@item_name = item_name
	    @type = type
	end

    def size
	    @element.Count
    end

    def [](index)
		return @type.new @element.Item index
    end

    def each
		size.times { |i| yield self[i] }
    end

    def add
	   e = @element.add_element @item_name do |e|
		    yield type.new e
       end
       @type.new(e)
    end

    def remove(index)
	    @element.DeleteElement index
    end
end