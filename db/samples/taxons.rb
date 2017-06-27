Spree::Sample.load_sample("taxonomies")
categories = Spree::Taxonomy.find_by_name!(I18n.t('spree.taxonomy_brands_name'))

taxons = 1.upto(10).to_a.map do
  Spree::Taxon.create(name: Faker::Commerce.department(1), taxonomy: categories)
end

Spree::Product.all.each do |product|
  product.taxons << taxons.sample
end