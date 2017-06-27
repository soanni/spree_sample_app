Spree::Product.all.each do |product|
  properties = {
    "Manufacturer" => Faker::Company.name,
    "Brand" => Faker::Company.name,
    "Model" => Faker::Company.duns_number,
  }
  properties.each do |prop_name, prop_value|
    product.set_property(prop_name, prop_value)
  end
end