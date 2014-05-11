require 'rubygems'
require 'logger'
require 'active_record'
require 'active_support'
require 'extractcontent'
require 'open-uri'
require 'kconv'
require 'erb'
require File.dirname(__FILE__) + "/fetcher"

ActiveRecord::Base.logger = Logger.new(STDOUT)
yaml = File.dirname(__FILE__) + '/../config/database.yml'
content = ERB.new(File.read(yaml)).result(binding)
dbconfig = YAML.load(content)
ActiveRecord::Base.establish_connection dbconfig['production']

Dir::glob("#{File.dirname(__FILE__)}/models/*.rb") do |f|
  load f
end
