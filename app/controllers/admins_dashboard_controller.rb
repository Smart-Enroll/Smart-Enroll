class AdminsDashboardController < ApplicationController
  def index
    @students = Student.all
    @courses = Course.all
  end

  def destroy_student
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to admins_dashboard_index_path, notice: 'Student deleted successfully'
  end

  def destroy_course
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to admins_dashboard_index_path, notice: 'Course deleted successfully'
  end
end
