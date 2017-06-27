namespace :db do
  desc "Generates EY's sample if database is empty"
  task :generate_sample_data => :environment do
    if Spree::User.none?
      puts "="*20, "Loading Seed Data", "="*20
      Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
      Spree::Core::Engine.load_seed if defined?(Spree::Core)
      SpreeSample::Engine.load_samples
      Rake::Task["db:dump"].invoke
    end
  end
end