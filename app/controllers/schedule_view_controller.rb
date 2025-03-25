class ScheduleViewController < ApplicationController
  def index
    # TODO - Add user from session not fixed
    @student = Student.first

    @term = Course.first&.term || "N/A"

    @user_schedules = @student.user_schedules.includes(:course)
  end
end
