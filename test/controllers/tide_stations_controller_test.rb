require "test_helper"

class TideStationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tide_station = tide_stations(:one)
  end

  test "should get index" do
    get tide_stations_url
    assert_response :success
  end

  test "should get new" do
    get new_tide_station_url
    assert_response :success
  end

  test "should create tide_station" do
    assert_difference("TideStation.count") do
      post tide_stations_url, params: { tide_station: { latitude: @tide_station.latitude, longitude: @tide_station.longitude, station_name: @tide_station.station_name, station_number: @tide_station.station_number } }
    end

    assert_redirected_to tide_station_url(TideStation.last)
  end

  test "should show tide_station" do
    get tide_station_url(@tide_station)
    assert_response :success
  end

  test "should get edit" do
    get edit_tide_station_url(@tide_station)
    assert_response :success
  end

  test "should update tide_station" do
    patch tide_station_url(@tide_station), params: { tide_station: { latitude: @tide_station.latitude, longitude: @tide_station.longitude, station_name: @tide_station.station_name, station_number: @tide_station.station_number } }
    assert_redirected_to tide_station_url(@tide_station)
  end

  test "should destroy tide_station" do
    assert_difference("TideStation.count", -1) do
      delete tide_station_url(@tide_station)
    end

    assert_redirected_to tide_stations_url
  end
end
