require "test_helper"

class ScheduleViewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get schedule_view_index_url
    assert_response :success
  end


  test "should create user_schedule" do
    assert_difference("UserSchedule.count", 1) do
      post schedule_view_index_url, params: { course_id: 102 }
    end
    assert_redirected_to schedule_view_index_url
  end

  test "should destroy user_schedule" do
    user_schedule = user_schedules(:one)
    assert_difference("UserSchedule.count", -1) do
      delete schedule_view_url(user_schedule)
    end
    assert_redirected_to schedule_view_index_url
  end
end
