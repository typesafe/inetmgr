
class WIN32OLE
	
	def set(name, value)
		self.Properties.Item(name).Value = value
	end

	def get(name)
		self.Properties.Item(name).Value
	end

    def add_element(name)
		e = self.Collection.CreateNewElement name
		yield e
        self.Collection.AddElement(e)
        e
    end

	def add_collection_element name
		self.add_element("add") { |e| e.set("name", name) }
	end

    def get_child_element(name)
	     self.ChildElements.Item name
    end

    def get_item_with_name(name)
		self.count.times do |i|
			p = self.Collection.Item i
			return p if (p.get("name") == name)
		end
		nil
    end

	def for_each
		self.count.times do |i|
      p = self.Collection.Item i      
      yield p      
    end
	end

    def first
	    self.Collection.Item 0 unless self.Collection.Count == 0
		nil
    end

    def count
	    self.Collection.Count
    end

end