class CreateNoaaSixMinTideByDates < ActiveRecord::Migration[7.0]
  def change
    create_table :noaa_six_min_tide_by_dates do |t|
      t.integer :station_number
      t.date :date
      t.text :data

      t.timestamps
    end
  end
end
