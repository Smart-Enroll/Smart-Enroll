class DashboardController < ApplicationController
  def index
    @student = Student.first # You can replace this with session-based logic later
  end
end
