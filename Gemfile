source 'https://rubygems.org'

ruby '2.5.7'

gem 'sinatra'
gem 'foreman'
gem 'thin'
gem 'rake'
gem 'activerecord'
gem 'activesupport'

gem 'extractcontent', :git => 'https://github.com/mono0x/extractcontent.git'

group :production do
  gem 'pg'
end

group :test, :development do
  gem 'sqlite3'
end

