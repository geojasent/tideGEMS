class CreateSunriseSunsets < ActiveRecord::Migration[7.0]
  def change
    create_table :sunrise_sunsets do |t|
      t.integer :station_number
      t.date :date
      t.time :sunrise
      t.time :sunset

      t.timestamps
    end
  end
end
