size = Spree::OptionType.find_by_presentation!("Size")
color = Spree::OptionType.find_by_presentation!("Color")
Spree::Product.all.each { |product| product.option_types = [size, color]; product.save }