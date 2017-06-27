on_app_master do
  run "ADMIN_EMAIL=spree@engineyard.com ADMIN_PASSWORD=engineyard bundle exec rake db:load_sample_if_empty_db"
end