require 'rubygems'
require 'data_mapper'
require 'sinatra/base'
require_relative './models/link'
require 'database_cleaner'

 ENV["RACK_ENV"] ||= "development"


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
		
	  Link.create(title: params[:linkname], url: params[:url])
		redirect'/links'
	end

	


run! if app_file == $0
end