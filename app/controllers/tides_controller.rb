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
    sunset = DateTime.parse([@selected_date, daily_sunrise_sunset_data[0].sunset].join(' '))
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
    sunrise_hash['data'] = { sunrise_string => 0 }
    @tide_sun_arr << sunrise_hash
    sunset_hash['name'] = 'Sunset'
    sunset_hash['data'] = { sunset_string => 0 }
    @tide_sun_arr << sunset_hash
  end

  def weekly_view
    begin_date = '20230501'
    converted_date = Time.parse begin_date
    db_date = converted_date.strftime('%Y-%m-%d')
    end_date = '20230507'
    tide_station = '9414290'
    sunday_date = Date.today.prev_occurring(:sunday).to_s
    @selected_date = params[:date] || sunday_date
    end_date = (@selected_date.to_date + 7).to_s

    # get tide data
    tide_data = NoaaSixMinTideByDate.all
    @daily_data = tide_data.where(date: @selected_date..end_date)
    # get sundays
    my_day = [0]
    @daily_data_date = tide_data.pluck(:date).to_a.select { |k| my_day.include?(k.wday) }

    @chart_weekly_data = []
    for i in 0..6 do
      temp = JSON.parse @daily_data[i].data
      @chart_weekly_data << temp
    end
    @chart_weekly_data = @chart_weekly_data.flatten(1)

    # get sunset data
    sun_array = []
    sunrise_array = []
    sunset_array = []
    sunrise_sunset_data = SunriseSunset.all
    daily_sunrise_sunset_data = sunrise_sunset_data.where(date: @selected_date..end_date)
    for i in 0..6 do
      sunrise = DateTime.parse([(@selected_date.to_date + i).to_s, daily_sunrise_sunset_data[i].sunrise].join(' '))
      sunrise_string = sunrise.strftime('%Y-%m-%d %H:%M')
      sun_array << sunrise_string
      sunrise_array << [sunrise_string, 0]
      sunset = DateTime.parse([(@selected_date.to_date + i).to_s, daily_sunrise_sunset_data[i].sunset].join(' '))
      sunset_string = sunset.strftime('%Y-%m-%d %H:%M')
      sun_array << sunset_string
      sunset_array << [sunset_string, 0]
    end

    # combine tide and sunrise sunset data
    @week_tide_sun_array = []
    tide_hash = {}
    sunrise_hash = {}
    sunset_hash = {}
    tide_hash['name'] = 'Tide'
    sunrise_hash['name'] = 'Sunrise'
    sunset_hash['name'] = 'Sunset'
    tide_hash['data'] = @chart_weekly_data.to_h
    sunrise_hash['data'] = sunrise_array.to_h
    sunset_hash['data'] = sunset_array.to_h
    @week_tide_sun_array << tide_hash
    @week_tide_sun_array << sunrise_hash
    @week_tide_sun_array << sunset_hash
  end
end
