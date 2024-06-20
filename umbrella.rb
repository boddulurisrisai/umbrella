require "http"
require "json"

puts "Hi, Where do you live?"
user_location = gets.chomp

gmaps_key = ENV.fetch("GMAPS_KEY")
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_key}"

x = HTTP.get(gmaps_url)

parsed_data = JSON.parse(x)

results_data = parsed_data.fetch("results")
location = results_data.at(0).fetch("geometry").fetch("bounds").fetch("northeast")
latitude = location.fetch("lat")
longitude = location.fetch("lng")

pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_key}/#{latitude},#{longitude}"

data = HTTP.get(pirate_weather_url)
json = JSON.parse(data)
temp = json.fetch("currently").fetch("temperature")
pp temp
