require "test_helper"

class AdminsDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_dashboard_index_url
    assert_response :success
  end
end
