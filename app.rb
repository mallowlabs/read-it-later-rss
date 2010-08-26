#!/usr/bin/env ruby -Ku
require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'rss'
require 'extractcontent'
require 'kconv'

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get '/' do
  if params[:name]
    # /?name=foo -> /foo
    redirect "/#{h params[:name]}"
  else
    erb :index
  end
end

get '/:name' do |name|
  @name = name
  erb :user
end

get '/:name/:target' do |name, target|
  content_type 'application/xml', :charset => 'utf-8'
  url = "http://readitlaterlist.com/users/#{h name}/feed/#{h target}"
  open(url) do |file|
    rss = RSS::Parser.parse(file.read)
    extractor = ExtractContent::Extractor.new
    rss.items.each do |item|
      puts item.link # DEBUG
      begin
        html = open(item.link).read
        body, title = extractor.analyse(html)
        item.title = title.toutf8
        item.description = body.toutf8
      rescue
        # Skip replacing on error
      end
    end
    rss.to_s
  end
end
