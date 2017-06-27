namespace :db do
  desc "Load EY's sample if database is empty"
  task :load_sample_if_empty_db => :environment do
    if !ActiveRecord::Base.connection.table_exists?(Spree::User.table_name) || Spree::User.none?
      puts "="*20, "Loading Seed Data from Dump", "="*20
      Rake::Task["db:restore"].invoke
      require File.join(Rails.root, 'db/samples/assets.rb')
      LoadAssetsInRestore.load
    end
  end
end