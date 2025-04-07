require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
    @student = students(:one)
    @student.user_schedules.destroy_all
    @integration_session = open_session
    @integration_session.cookies["student_id"] = @student.id
  end


  test "should create course" do
    assert_difference("Course.count") do
      post courses_url, params: { course: { CRN: 123456, class_name: "Test Course", professor: "Dr. Smith", term: "Fall 2025", credits: 3, class_time: "2000-01-01 10:00:00", prerequisite: "None", status: "Open", major: "Computer Science" } }
    end
    assert_redirected_to admin_dashboard_path
  end

  test "should not enroll if prerequisite not met" do
    # Use an existing course as the prerequisite.
    prerequisite_course = courses(:one)
    # Create a new course that requires the prerequisite.
    course_with_prereq = Course.create!(
      CRN: 123457,
      class_name: "Advanced Course",
      professor: "Dr. Example",
      term: "Fall 2025",
      credits: 3,
      class_time: "2000-01-01 11:00:00",
      prerequisite: prerequisite_course.class_name,  # e.g. "Database Design"
      status: "Open",
      major: "Computer Science"
    )

    # Ensure the student is NOT enrolled in the prerequisite course.
    assert_not @student.user_schedules.where(course_id: prerequisite_course.CRN, status: "Planned").exists?

    # Attempt to enroll; no new UserSchedule should be created.
    assert_no_difference("UserSchedule.count") do
      @integration_session.post enroll_course_url(course_with_prereq)
    end

    # Expect a redirect with flash alert.
    assert_redirected_to courses_path
    expected_alert = "You cannot enroll in Advanced Course because you have not completed the prerequisite: #{prerequisite_course.class_name}."
    assert_equal expected_alert, flash[:alert]
  end

  test "should enroll if prerequisite met" do
    prerequisite_course = courses(:two)
    course_with_prereq = Course.create!(
      CRN: 123458,
      class_name: "Advanced Course",
      professor: "Dr. Example",
      term: "Fall 2025",
      credits: 3,
      class_time: "2000-01-01 11:00:00",
      prerequisite: prerequisite_course.class_name,
      status: "Open",
      major: "Computer Science"
    )

    # Enroll the student in the prerequisite course.
    UserSchedule.create!(
      student_id: @student.id,
      course_id: prerequisite_course.CRN,
      term: prerequisite_course.term,
      status: "Planned"
    )

    # Now enrollment should succeed.
    assert_difference("UserSchedule.count", 1) do
      @integration_session.post enroll_course_url(course_with_prereq)
    end
    assert_redirected_to courses_path
    assert_match /Successfully enrolled in Advanced Course/, flash[:notice]
  end

  test "should update course" do
    patch course_url(@course), params: { course: { class_name: "Updated Course" } }
    assert_redirected_to admin_dashboard_path
    @course.reload
    assert_equal "Updated Course", @course.class_name
  end

  test "should destroy course" do
    assert_difference("Course.count", -1) do
      delete course_url(@course)
    end
    assert_redirected_to admin_dashboard_path
  end
end
