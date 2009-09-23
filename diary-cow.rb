require 'rubygems'
require 'sinatra'
require 'configuration'

get '/' do
  redirect '/index'
end

get '/index' do
  haml :index
end

get '/create' do
  haml :create
end

get '/edit/:month/:day/:year/?' do
  haml :edit
end

get '/view/:month/:day/:year/?' do
  haml :view
end

get '/list' do
  @entries = Entry.all
  haml :list
end

get '/search' do
  haml :search
end