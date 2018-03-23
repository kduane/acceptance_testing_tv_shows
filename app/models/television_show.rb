class TelevisionShow
  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]
  attr_reader :title, :network, :starting_year, :synopsis, :genre

  def initialize(title, network, starting_year, synopsis, genre)
    @title = title
    @network = network
    @starting_year = starting_year
    @synopsis = synopsis
    @genre = genre
  end

  def summary
    "Title: #{@title} \n Network: #{@network}\n Starting Year: #{@starting_year}\n Synopsis: #{@synopsis}\n Genre: #{@genre}"
  end

end
