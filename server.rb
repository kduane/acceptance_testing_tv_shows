require 'sinatra'
require 'csv'
require_relative "app/models/television_show"

set :bind, '0.0.0.0'  # bind to all interfaces
set :views, File.join(File.dirname(__FILE__), "app/views")

get '/television_shows' do
  @television_shows = []

  CSV.foreach("television_shows.csv", :headers => true, :col_sep = ',') do |row|
    @television_shows << Television_Show.new(:title => row['title'], :network => row['network'], :starting_year => row['starting
      '], :synopsis => row['synopsis'], :genre => row['genre'])
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
  CSV.open("television_shows.csv", "a+") do |csv|
    csv << [title, network, starting_year, synopsis, genre]
end
