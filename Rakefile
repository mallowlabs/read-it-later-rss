require 'rubygems'
require './lib/boot'

namespace :db do
  desc "migrate database"
  task :migrate do
    ActiveRecord::Migrator.migrate('db/migrate',
          ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end
end

task :cron do
  Page.delete_all(["created_at < ?", Time.now - 30.days])
end

