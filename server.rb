require 'sinatra'
require 'csv'
require_relative "app/models/television_show"
require 'pry'
require "pry" if development? || test?
require "sinatra/reloader" if development?

set :bind, '0.0.0.0'  # bind to all interfaces
set :views, File.join(File.dirname(__FILE__), "app/views")
se Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe",
}

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
  # binding.pry
  if params.values.any?{|i| i.empty?}
    @message = "Please fill in all required fields"
    redirect '/television_shows/new'
  else
    title = params[:title]
    network = params[:network]
    starting_year = params[:starting_year]
    synopsis = params[:synopsis]
    genre = params[:genre]
    CSV.open("television-shows.csv", "a+") do |csv|
      csv << [title, network, starting_year, synopsis, genre]
    end
    redirect '/television_shows'
  end
end
