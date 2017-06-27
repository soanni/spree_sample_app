Spree::Sample.load_sample("tax_categories")
Spree::Sample.load_sample("shipping_categories")

clothing = Spree::TaxCategory.find_by_name!("Clothing")

products = 1.upto(100).map do
  usd_price = Faker::Commerce.price
  eur_price = usd_price * 1.13
  {
    name:           Faker::Commerce.product_name,
    tax_category:   clothing,
    price:          usd_price,
    eur_price:      eur_price,
  }
end

default_shipping_category = Spree::ShippingCategory.find_by_name!("Default")

products.each do |product_attrs|
  Spree::Config[:currency] = "USD"
  eur_price = product_attrs.delete(:eur_price)

  new_product = Spree::Product.where(name: product_attrs[:name],
                                     tax_category: product_attrs[:tax_category]).first_or_create! do |product|
    product.price = product_attrs[:price]
    product.description = Faker::Lorem.paragraph
    product.available_on = Time.zone.now
    product.shipping_category = default_shipping_category
  end

  if new_product
    Spree::Config[:currency] = "EUR"
    new_product.reload
    new_product.price = eur_price
    new_product.save
  end
end

Spree::Config[:currency] = "USD"
