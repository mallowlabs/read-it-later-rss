require 'rubygems'
require 'active_record'
require 'extractcontent'
require 'open-uri'
require 'kconv'
require File.dirname(__FILE__) + "/fetcher"

ActiveRecord::Base.logger = Logger.new(STDOUT)
dbconfig = YAML.load(File.read(File.dirname(__FILE__) + '/../config/database.yml'))
ActiveRecord::Base.establish_connection dbconfig['production']

Dir::glob("#{File.dirname(__FILE__)}/models/*.rb") do |f|
  load f
end
