small = Spree::OptionValue.where(name: "Small").first
medium = Spree::OptionValue.where(name: "Medium").first
large = Spree::OptionValue.where(name: "Large").first
extra_large = Spree::OptionValue.where(name: "Extra Large").first

red = Spree::OptionValue.where(name: "Red").first
blue = Spree::OptionValue.where(name: "Blue").first
green = Spree::OptionValue.where(name: "Green").first

sizes = [small, medium, large, extra_large]
colors = [red, blue, green]

Spree::Product.all.each do |product|
  variant_count = 1.upto(5).to_a.sample
  variant_count.times do
    Spree::Variant.create(
      product: product,
      sku: /PRD-\d{5}/.gen,
      cost_price: Faker::Commerce.price,
      option_values: [sizes.sample, colors.sample]
    )
  end
  
end

