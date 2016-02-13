 ENV["RACK_ENV"] ||= "development"

require 'rubygems'
require 'data_mapper'
require 'sinatra/base'
require_relative 'models/link'
require 'database_cleaner'




class BookmarkManager < Sinatra::Base


	get '/links' do
		#'Hello world!'
		@links = Link.all
		erb :homepage
	end

	get '/links/new' do
		erb :add_sites
	end	

	post '/links' do
		link = Link.new(title: params[:linkname], url: params[:url])
 		tag = Tag.create(tag: params[:tag])

 		link.tags << tag

 		link.save

 		redirect to('/links')


	 #  Link.create(title: params[:linkname], url: params[:url])
		# redirect'/links'
	end

	


run! if app_file == $0
end