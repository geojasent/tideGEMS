class TidesController < ApplicationController
  def index
    begin_date = '20230501'
    converted_date = Time.parse begin_date
    db_date = converted_date.strftime('%Y-%m-%d')
    end_date = '20230507'
    tide_station = '9414290'
    current_date = DateTime.now.strftime('%Y-%m-%d')
    @selected_date = params[:date] || current_date

    tide_data = NoaaSixMinTideByDate.all
    @daily_data = tide_data.where(date: @selected_date)
    @daily_data_date = tide_data.pluck(:date)  
    @chart_daily_data = JSON.parse @daily_data[0].data

    sunrise_sunset_data = SunriseSunset.all
    daily_sunrise_sunset_data = sunrise_sunset_data.where(date: @selected_date)
    sunrise = DateTime.parse([@selected_date, daily_sunrise_sunset_data[0].sunrise].join(' '))
    sunrise_string = sunrise.strftime('%Y-%m-%d %H:%M')
    # @sunrise = daily_sunrise_sunset_data[0].sunrise
    sunset = DateTime.parse([@selected_date, daily_sunrise_sunset_data[0].sunset].join(' '))
    # @sunset = daily_sunrise_sunset_data[0].sunset
    sunset_string = sunset.strftime('%Y-%m-%d %H:%M')

    # combine tide and sunrise sunset data
    @tide_sun_arr = []
    tide_hash = {}
    sunrise_hash = {}
    sunset_hash = {}
    tide_hash['name'] = 'Tide'
    tide_hash['data'] = @chart_daily_data.to_h
    @tide_sun_arr << tide_hash
    sunrise_hash['name'] = 'Sunrise'
    sunrise_hash['data'] = {sunrise_string => 0}
    @tide_sun_arr << sunrise_hash
    sunset_hash['name'] = 'Sunset'
    sunset_hash['data'] = {sunset_string => 0}
    @tide_sun_arr << sunset_hash
  end

  def weekly_tide
  end
end
