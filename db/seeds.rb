# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb (opcional)
require "open-uri"
require "json"

Movie.destroy_all
url = "https://tmdb.lewagon.com/movie/top_rated"
data = JSON.parse(URI.open(url).read)

data["results"].first(20).each do |m|
  Movie.create!(
    title: m["title"],
    overview: m["overview"],
    poster_url: "https://image.tmdb.org/t/p/original#{m['poster_path']}",
    rating: m["vote_average"].to_f
  )
end
puts "Movies from TMDB: #{Movie.count}"
