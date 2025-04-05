class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    if session[:student_id]
      @current_user ||= Student.find_by(id: session[:student_id])
    elsif session[:admin_id]
      @current_user ||= Admin.find_by(id: session[:admin_id])
    end
  end

  def logged_in?
    current_user.present?
  end
end
