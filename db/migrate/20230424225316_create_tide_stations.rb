class CreateTideStations < ActiveRecord::Migration[7.0]
  def change
    create_table :tide_stations, if_not_exists: true do |t|
      t.string :station_name
      t.integer :station_number
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
