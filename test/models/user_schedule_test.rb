require "test_helper"

class UserScheduleTest < ActiveSupport::TestCase
  def setup
    @student = Student.create!(
      email: "test@student.com",
      name: "Test Student",
      password: "password",
      credits_earned: 0
    )
    @course = Course.create!(
      CRN: 12345,
      class_name: "Test Course",
      professor: "Test Professor",
      term: "Fall 2025",
      credits: 3,
      class_time: "2000-01-01 10:00:00"
    )
    @user_schedule = UserSchedule.create!(student: @student, course: @course)
  end

  # Test to see if the user_Schedule properties match
  test "should create user_schedule with valid student and course associations" do
    assert @user_schedule.valid?, "UserSchedule should be valid with proper associations"
    assert_equal @student, @user_schedule.student, "Associated student should be the one created in setup"
    assert_equal @course, @user_schedule.course, "Associated course should be the one created in setup"
  end

  # Test to make sure we cant have a course schedule without a student
  test "should not be valid without a student" do
    invalid_schedule = UserSchedule.new(course: @course)
    assert_not invalid_schedule.valid?, "UserSchedule should be invalid without a student"
  end

  # Test to make sure we cant have a course schedule without a course
  test "should not be valid without a course" do
    invalid_schedule = UserSchedule.new(student: @student)
    assert_not invalid_schedule.valid?, "UserSchedule should be invalid without a course"
  end
end
