Spree::Sample.load_sample("addresses")

orders = 1.upto(500).map do
  order = Spree::Order.create(number: /R\d{9}/.gen, email: Faker::Internet.email)
  item_count = 1.upto(3).to_a.sample
  item_count.times do
    variant = Spree::Variant.all.sample
    order.line_items.create(
      variant: variant,
      quantity: 1,
      price: variant.price
    )
  end
  order
end

orders.each(&:create_proposed_shipments)

orders.each do |order|
  days_ago = 1.upto(100).to_a.sample
  order.state = "complete"
  order.completed_at = Time.current - days_ago.day
  order.save
end
