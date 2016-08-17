ENV["RACK_ENV"] ||= "development"

require 'rubygems'
require 'data_mapper'
require 'sinatra/base'
require_relative 'data_mapper_setup'
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'models/user'
require 'database_cleaner'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base

  register Sinatra::Flash

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

  enable :sessions
  set :session_secret, 'super_secret'

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email],
                password: params[:password],
                password_confirmation: params[:password_confirmation])
    if @user.save #save returns true or false depending on whether the model is saved to the database
      session[:user_id] = @user.id
      redirect to('/links')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end
run! if app_file == $0
end