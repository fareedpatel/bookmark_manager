ENV["RACK_ENV"] ||= "development"

require 'rubygems'
require 'data_mapper'
require 'sinatra/base'
require_relative 'data_mapper_setup'
require_relative 'models/link'
require_relative 'models/tag'
require 'database_cleaner'

class BookmarkManager < Sinatra::Base

	get '/links' do
		@links = Link.all
		erb :homepage
	end

	get '/links/new' do
		erb :add_sites
	end

	post '/links' do
		link = Link.create(title: params[:title], 
                  url: params[:url])
 		params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
 		link.save
 		redirect ('/links')
	end

  get '/tags/:name' do
    tag = Tag.all(name: params[:name])
    @links = tag ? tag.links : []
    erb :'homepage'
  end

run! if app_file == $0
end