class AutoStartProvider < IisObject
  attr_accessor :name
  attr_accessor :type

  def create
    configure do |m|
      section = m.get_config_section "system.applicationHost/serviceAutoStartProviders"

      element = section.Collection.CreateNewElement("add");
      element.Properties.Item("name").Value = @name
      element.Properties.Item("type").Value = @type
      section.Collection.AddElement(element)
    end   
  end
end