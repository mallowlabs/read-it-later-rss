require 'rubygems'
require 'active_record'
require 'lib/boot'

namespace :db do
  desc "migrate database"
  task :migrate do
    ActiveRecord::Migrator.migrate('db/migrate',
          ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end
end


