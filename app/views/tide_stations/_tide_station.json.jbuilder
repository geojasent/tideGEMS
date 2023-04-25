json.extract! tide_station, :id, :station_name, :station_number, :latitude, :longitude, :created_at, :updated_at
json.url tide_station_url(tide_station, format: :json)
