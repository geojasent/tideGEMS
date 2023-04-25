require "application_system_test_case"

class TideStationsTest < ApplicationSystemTestCase
  setup do
    @tide_station = tide_stations(:one)
  end

  test "visiting the index" do
    visit tide_stations_url
    assert_selector "h1", text: "Tide stations"
  end

  test "should create tide station" do
    visit tide_stations_url
    click_on "New tide station"

    fill_in "Latitude", with: @tide_station.latitude
    fill_in "Longitude", with: @tide_station.longitude
    fill_in "Station name", with: @tide_station.station_name
    fill_in "Station number", with: @tide_station.station_number
    click_on "Create Tide station"

    assert_text "Tide station was successfully created"
    click_on "Back"
  end

  test "should update Tide station" do
    visit tide_station_url(@tide_station)
    click_on "Edit this tide station", match: :first

    fill_in "Latitude", with: @tide_station.latitude
    fill_in "Longitude", with: @tide_station.longitude
    fill_in "Station name", with: @tide_station.station_name
    fill_in "Station number", with: @tide_station.station_number
    click_on "Update Tide station"

    assert_text "Tide station was successfully updated"
    click_on "Back"
  end

  test "should destroy Tide station" do
    visit tide_station_url(@tide_station)
    click_on "Destroy this tide station", match: :first

    assert_text "Tide station was successfully destroyed"
  end
end
