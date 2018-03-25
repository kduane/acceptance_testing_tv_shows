require 'sinatra'
require 'csv'
require_relative "app/models/television_show"

set :bind, '0.0.0.0'  # bind to all interfaces
set :views, File.join(File.dirname(__FILE__), "app/views")

get '/television_shows' do
  @television_shows = []

  CSV.foreach("television-shows.csv", :headers => true, :col_sep => ',') do |row|
    @television_shows << TelevisionShow.new(row['title'], row['network'], row['starting_year'], row['synopsis'], row['genre'])
  end

  erb :index
end

get '/television_shows/new' do
  erb :new
end

post '/television_show' do
  title = params['title']
  network = params['network']
  starting_year = params['starting_year']
  synopsis = params['synopsis']
  genre = params['genre']
  # binding.pry
  CSV.open("television-shows.csv", "a+") do |csv|
    csv << [title, network, starting_year, synopsis, genre]
  end
  redirect '/television_shows'
end
