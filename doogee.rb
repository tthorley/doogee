require 'rubygems'
require 'sinatra'
require 'haml'
require 'configuration'

TODAY = Date.today

get '/' do
  redirect '/index'
end

get '/index' do
  haml :index
end

get '/create' do
  if entry_for(TODAY)
    redirect '/edit/' + TODAY.for_url
  else
    haml :create
  end
end

post '/save' do
  content = params[:writing]
  entry = Entry.new(:dated => TODAY, :content => content)
  entry.save
  redirect '/view/' + date.for_url
end

get '/edit/:month-:day-:year/?' do
  date = Date.from_params(params)
  @entry = entry_for(date)
  haml :edit
end

post '/modify/:id' do
  @entry = Entry.get(params[:id])
  redirect :view
end

get '/view/:month-:day-:year/?' do
  date = Date.from_params(params)
  @entry = entry_for(date)
  haml :view
end

get '/list' do
  @entries = Entry.all
  haml :list
end

get '/search' do
  haml :search
end