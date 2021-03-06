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
  entry = Entry.new(:day => TODAY, :content => content)
  entry.save
  @index ||= get_ferret_index
  @index.add_entry(entry)
  redirect '/view/' + TODAY.for_url
end

get '/edit/:month-:day-:year/?' do
  date = Date.from_params(params)
  @entry = entry_for(date)
  haml :edit
end

post '/modify/:id' do
  entry = Entry.get(params[:id])
  entry.content = params[:editing]
  entry.save
  @index ||= get_ferret_index
  # you can't modify something that is in the index, so
  # you have to delete and readd
  @index.delete_entry_with_id(entry.id)
  @index.add_entry(entry)
  redirect '/view/' + entry.day.for_url
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
  if params["query"]
    @results = Entry.all
  else
    @results = []
  end
  haml :search
end