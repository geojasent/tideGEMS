# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'rest-client'

puts 'Getting tide data'
def tides_from_noaa
  begin_date = '20230501'
  end_date = '20230507'
  station_number = '9414290'
  response = RestClient.get("https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?begin_date=#{begin_date}&end_date=#{end_date}&station=#{station_number}&product=predictions&datum=NAVD&time_zone=lst&units=english&format=json")
  parsed_json = JSON.parse(response.body)

  prev_date_time = Time.parse begin_date
  prev_date = prev_date_time.strftime('%Y-%m-%d')
  predictions = []

  parsed_json['predictions'].each do |data|
    date_time = Time.parse data['t']
    date = date_time.strftime('%Y-%m-%d')

    if date == prev_date
      predictions << [data['t'], data['v']]
    else
      NoaaSixMinTideByDate.create(
        station_number: station_number,
        date: prev_date,
        data: predictions
      )
      predictions = []
      prev_date = date
    end
  end
end

tides_from_noaa()
puts 'Seeding tide data'
