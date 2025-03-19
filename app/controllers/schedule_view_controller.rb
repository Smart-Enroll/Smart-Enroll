class ScheduleViewController < ApplicationController
  def index
    @term = Course.first&.term || "N/A"  # Avoid nil error if no courses exist
    @user_schedules = UserSchedule.all || []  # Ensure @user_schedules is always an array
  end
end
