require "test_helper"

class TidesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tides_index_url
    assert_response :success
  end
end
