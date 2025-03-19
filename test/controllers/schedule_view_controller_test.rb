require "test_helper"

class ScheduleViewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get schedule_view_index_url
    assert_response :success
  end
end
