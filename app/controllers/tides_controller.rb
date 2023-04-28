class TidesController < ApplicationController
  def index
    begin_date = '20230501'
    converted_date = Time.parse begin_date
    db_date = converted_date.strftime('%Y-%m-%d')
    end_date = '20230507'
    tide_station = '9414290'

    tide_data = NoaaSixMinTideByDate.all
    @daily_data = JSON.parse tide_data[0].data
  end

  def weekly_tide
  end
  
end
