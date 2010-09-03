#!/usr/bin/env ruby -Ku
require 'rubygems'
require File.dirname(__FILE__) + "/lib/boot"
require 'sinatra'
require 'rss'

helpers do
  include Rack::Utils; alias_method :h, :escape_html

  def partial(renderer, template, options = {})
    options = options.merge({:layout => false})
    template = "_#{template.to_s}".to_sym
    m = method(renderer)
    m.call(template, options)
  end
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
    fetcher = Fetcher.new
    rss.items.each do |item|
      begin
        body, title = fetcher.fetch(item.link)
        item.title = title
        item.description = body
      rescue
        # Skip replacing on error
      end
    end
    rss.to_s
  end
end
