class ScheduleViewController < ApplicationController
  def index
    # TODO - Add user from session not fixed
    @student = Student.find(session[:student_id])  # Ensure the student is found

    @term = Course.first&.term || "N/A"
    
    @enrolled_courses = @student.courses  # Fetch enrolled courses

    @user_schedules = @student.user_schedules.includes(:course)
  end

  def create
    student = Student.find(session[:student_id])  # Find the student from session
    course = Course.find(params[:course_id])  # Find the selected course

    # Create a new UserSchedule with the same term as the course
    UserSchedule.create!(student_id: student.id, course_id: course.id, term: course.term)

    redirect_to schedule_view_index_path, notice: "Course added to your schedule for #{course.term}!"
  end

  def destroy
    user_schedule = UserSchedule.find(params[:id])
    user_schedule.destroy

    redirect_to schedule_view_index_path, notice: "Course removed from your schedule."
  end
end
