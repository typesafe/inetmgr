class String
   def to_camel_case
		self.gsub(/_(.)/) { $1.upcase }
   end
end