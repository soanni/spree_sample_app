# Don't load assets during sample generation.
# Only load in restore
module LoadAssetsInRestore
  extend self

  def load
    Spree::Product.all.each do |product|
      variant       = product.master
      random_image  = images.sample
      variant.images.create!(random_image) if variant.images.none?
    end
  end

  def images
    [
      'apache_baseball.png',
      'ror_bag.jpeg',
      'ror_baseball.jpeg',
      'ror_baseball_back.jpeg',
      'ror_baseball_jersey_back_blue.png',
      'ror_baseball_jersey_back_green.png',
      'ror_baseball_jersey_back_red.png',
      'ror_baseball_jersey_blue.png',
      'ror_baseball_jersey_green.png',
      'ror_baseball_jersey_red.png',
      'ror_jr_spaghetti.jpeg',
      'ror_mug.jpeg',
      'ror_mug_back.jpeg',
      'ror_ringer.jpeg',
      'ror_ringer_back.jpeg',
      'ror_stein.jpeg',
      'ror_stein_back.jpeg',
      'ror_tote.jpeg',
      'ror_tote_back.jpeg',
      'ruby_baseball.png',
      'spree_bag.jpeg',
      'spree_jersey.jpeg',
      'spree_jersey_back.jpeg',
      'spree_mug.jpeg',
      'spree_mug_back.jpeg',
      'spree_ringer_t.jpeg',
      'spree_ringer_t_back.jpeg',
      'spree_spaghetti.jpeg',
      'spree_stein.jpeg',
      'spree_stein_back.jpeg',
      'spree_tote_back.jpeg',
      'spree_tote_front.jpeg',
    ].map { |product| { attachment: image(product)} } 
  end
  
  def image(name)
    images_path = Pathname.new(File.dirname(__FILE__)) + "images"
    path = images_path + name
    return false if !File.exist?(path)
    File.open(path)
  end

end