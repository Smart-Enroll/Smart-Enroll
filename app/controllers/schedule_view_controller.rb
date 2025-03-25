class ScheduleViewController < ApplicationController
  def index
    # TODO - Add user from session not fixed
    @student = Student.first

    @term = Course.first&.term || "N/A"

    @user_schedules = @student.user_schedules.includes(:course)
  end




  def create
    # Grab student and course_Id
    student = Student.first
    course_id = params[:course_id]

    # Create a new record joining the two values
    UserSchedule.create!(student_id: student.id, course_id: course_id)

    redirect_to schedule_view_index_path, notice: "Course added to your schedule!"
  end

  def destroy
    user_schedule = UserSchedule.find(params[:id])
    user_schedule.destroy

    redirect_to schedule_view_index_path, notice: "Course removed from your schedule."
  end
end
