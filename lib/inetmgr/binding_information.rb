class BindingInformation
  attr_accessor :binding_information
  attr_accessor :protocol

  def initialize(binding_information = "*:80:", protocol = "http")
    @binding_information = binding_information
    @protocol = protocol
  end
end