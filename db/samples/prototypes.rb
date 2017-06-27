prototypes = [
  {
    name: "Shirt",
    properties: ["Manufacturer", "Brand", "Model"]
  }
]

prototypes.each do |prototype_attrs|
  prototype = Spree::Prototype.where(name: prototype_attrs[:name]).first_or_create!
  prototype_attrs[:properties].each do |property_name|
    property = Spree::Property.where(name: property_name).first
    prototype.properties << property unless prototype.properties.include?(property)
  end
end
