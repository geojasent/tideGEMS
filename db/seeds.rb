# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'rest-client'

def tides_from_noaa
  puts 'Getting tide data'
  begin_date = '20230507'
  end_date = '20230508'
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
  puts 'Seeding tide data'
end

def sunrise_sunset_from_api
  puts 'Getting sunrise sunset times'
  begin_date = '20230601'
  end_date = '20230630'
  station_number = '9414290'
  latitude = '37.806375'
  longitude = '-122.466057'

  begin_date_p = Date.parse(begin_date)
  end_date_p = Date.parse(end_date)

  (begin_date_p..end_date_p).each do |day|
    response = RestClient.get("https://api.sunrise-sunset.org/json?lat=#{latitude}&lng=#{longitude}&date=#{day}")
    res = JSON.parse(response.body)['results']

    res_sunrise_time = DateTime.parse(res['sunrise'])
    res_sunset_time = DateTime.parse(res['sunset'])

    time_zone = ActiveSupport::TimeZone.find_tzinfo('Pacific Time (US & Canada)')
    res_sunrise_time_zone = res_sunrise_time.in_time_zone(time_zone)
    res_sunset_time_zone = res_sunset_time.in_time_zone(time_zone)

    formatted_sunrise = res_sunrise_time_zone.strftime('%I:%M %P')
    formatted_sunset = res_sunset_time_zone.strftime('%I:%M %P')

    SunriseSunset.create(
      station_number: station_number,
      date: day,
      sunrise: formatted_sunrise,
      sunset: formatted_sunset
    )
  end
  puts 'Seeding sunrise sunset times'
end
# tides_from_noaa()
# sunrise_sunset_from_api()
