# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'
require 'open-uri'

Movie.destroy_all
List.destroy_all

# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
# Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)

url = "https://tmdb.lewagon.com/movie/top_rated"
movie_api = URI.open(url).read
movie = JSON.parse(movie_api)
movie["results"].each do |result|
  Movie.create(title: result["title"], overview: result["overview"], poster_url: "https://image.tmdb.org/t/p/w500#{result["poster_path"]}", rating: result["vote_average"].to_s[0..1].to_f)
end


# Bookmark.create!(comment: "It is a very good movie!", movie_id: 65, list_id: 1)

file = URI.open("https://i.natgeofe.com/n/e16c207c-c151-47ea-bbfd-85bafefc19ee/18-iconic-patagonia-torres-del-paine-national-park-chile_16x9.jpg?w=1200")
list = List.new(name: "Documentary")
list.photo.attach(io: file, filename: "documentary.png", content_type: "image/jpg")
list.save!
