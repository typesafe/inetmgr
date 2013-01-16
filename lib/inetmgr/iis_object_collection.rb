module Inetmgr

# Represents a collection of IIS configuration objects.
class IisObjectCollection
  include Enumerable
	def initialize element, item_name, type, add_callback = nil
		@collection_element = element
		@item_name = item_name
	    @type = type
		@add_callback = add_callback
	end

    def size
	    @collection_element.Count
    end

	def count
		size
	end

    def [](index)
		return @type.new @collection_element.Item index
    end

    def each
		size.times { |i| yield self[i] }
    end

    def add
		e = @collection_element.CreateNewElement @item_name.to_s
	    added = @type.new e
		@add_callback.call added unless @add_callback.nil?
	    yield added
        @collection_element.AddElement e
		added
    end

	def find
		size.times do |i|
			instance = self[i]
			return instance if yield(instance)
		end
		nil
	end

	def exists(name)
		!(find {|s| s.name == name}).nil?
	end

    def remove(index)
	    @collection_element.DeleteElement index
    end
end
end