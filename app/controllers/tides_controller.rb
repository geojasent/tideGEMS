class TidesController < ApplicationController
  def index
    begin_date = '20230501'
    converted_date = Time.parse begin_date
    db_date = converted_date.strftime('%Y-%m-%d')
    end_date = '20230507'
    tide_station = '9414290'
    current_date = DateTime.now.strftime('%Y-%m-%d')
    @selected_date = params[:date] || current_date

    @tide_data = NoaaSixMinTideByDate.all
    @daily_data = @tide_data.where(date: @selected_date)
    @daily_data_date = @tide_data.pluck(:date)
  end

  def weekly_tide
  end
  
end
