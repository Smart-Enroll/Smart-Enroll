require "test_helper"

class AdminsDashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = Admin.create!(
      name: "Test Admin",
      email: "admin@example.com",
      password: "password",
      role: "admin"
    )
  end

  test "should get index as admin" do
    # Simulate login
    post login_path, params: { email: @admin.email, password: "password" }
    
    get admins_dashboard_index_path
    assert_response :success
    assert_select "h2", "Students"  # assuming this appears on the dashboard
    assert_select "h2", "Courses"
  end
end
