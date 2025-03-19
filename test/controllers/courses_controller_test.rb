require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one) # Assumes you have a fixture for courses
  end

  test "should create course" do
    assert_difference('Course.count') do
      post courses_url, params: { course: { CRN: 123456, class_name: "Test Course", professor: "Dr. Smith", term: "Fall 2025", credits: 3, class_time: "MWF 10:00 AM" } }
    end
    assert_redirected_to course_url(Course.last)
  end

  test "should update course" do
    patch course_url(@course), params: { course: { class_name: "Updated Course" } }
    assert_redirected_to course_url(@course)
    @course.reload
    assert_equal "Updated Course", @course.class_name
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete course_url(@course)
    end
    assert_redirected_to courses_url
  end

  # test "should get index" do
  #   get courses_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_course_url
  #   assert_response :success
  # end

  # test "should show course" do
  #   get course_url(@course)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_course_url(@course)
  #   assert_response :success
  # end
end
