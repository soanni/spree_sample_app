# lib/tasks/db.rake
require 'fileutils'
namespace :db do

  desc "Dumps the database to db/sample_dump.sql"
  task :dump => :environment do
    with_config do |app, host, db, user, password|
      file_path = "#{Rails.root}/db/sample_dump"
      system "mysqldump --quick --user=#{user} --password=#{password} #{db} > #{file_path}.sql"
      io = Tar.tar("#{file_path}.sql")
      gz = Tar.gzip(io)
      File.open("#{file_path}.tar.gz", 'w') { |file| file.binmode; file.write(gz.read) }
      FileUtils.rm("#{file_path}.sql")
    end
  end

  desc "Restores the database dump at db/sample_dump.sql"
  task :restore => :environment do
    with_config do |app, host, db, user, password|
      file_path = "#{Rails.root}/db/sample_dump"
      gz = File.open("#{file_path}.tar.gz")
      io = Tar.ungzip(gz)
      Tar.untar(io, "#{file_path}.sql")
      system "mysql --user=#{user} --password=#{password} #{db} < #{file_path}.sql"
      FileUtils.rm("#{file_path}.sql")
    end
  end

  private

  def with_config
    yield Rails.application.class.parent_name.underscore,
      ActiveRecord::Base.connection_config[:host],
      ActiveRecord::Base.connection_config[:database],
      ActiveRecord::Base.connection_config[:username],
      ActiveRecord::Base.connection_config[:password]
  end
end