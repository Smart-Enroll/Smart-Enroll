class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:dashboard]

  # GET /students
  def index
    @students = Student.all
  end

  # Student dashboard
  def dashboard
    @student = Student.find(session[:student_id])
  end

  # GET /students/:id
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to root_path, notice: 'Student was successfully created. Please log in.'
    else
      render :new
    end
  end

  # GET /students/:id/edit
  def edit
  end

  def notifications
    @student = Student.find(session[:student_id])
  
    # If you have a Notification model related to Student:
    # @notifications = @student.notifications.order(created_at: :desc)
  
    # For now, placeholder data:
    @notifications = [
      { title: "New Course Added", body: "The course 'Advanced Algorithms' has been added to your major.", created_at: Time.now - 1.day },
      { title: "Course Updated", body: "The course 'Software Engineering' schedule has been updated.", created_at: Time.now - 2.days }
    ]
  end
  

  # PATCH/PUT /students/:id
  def update
    if @student.update(student_params)
      # If the user changes their email or username, update the session
      if params[:student][:email] != @student.email
        session[:student_id] = @student.id
      end
  
      render json: { success: true, student: @student }
    else
      render json: { success: false, errors: @student.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def edit_password
    @student = Student.find_by(id: session[:student_id])
    return redirect_to dashboard_path, alert: "Student not found." unless @student
  end
  
  def update_password
    @student = Student.find_by(id: session[:student_id])
    return redirect_to dashboard_path, alert: "Student not found." unless @student
  
    if @student.authenticate(params[:student][:current_password])
      if @student.update(password_params)
        redirect_to @student, notice: "Password successfully updated."
      else
        render :edit_password
      end
    else
      flash.now[:alert] = "Current password is incorrect."
      render :edit_password
    end
  end
  
  
  

  # DELETE /students/:id
  def destroy
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully removed.'
  end

  private

  def require_login
    unless session[:student_id] && Student.exists?(session[:student_id])
      respond_to do |format|
        format.html { redirect_to login_path, alert: "You must be logged in to access the dashboard" }
        format.json { render json: { success: false, error: "Unauthorized. Please log in." }, status: :unauthorized }
      end
    end
  end
  
  
  private
  
  def password_params
    params.require(:student).permit(:password, :password_confirmation)
  end
  
  def set_student
    @student = Student.find_by(id: params[:id]) || Student.find_by(id: session[:student_id])
  end
  

  def student_params
    if action_name == "create"
      params.require(:student).permit(:name, :email, :major, :password, :password_confirmation)
    else
      params.require(:student).permit(:name, :email)  # Only allow name and email for updates
    end
  end
  
end
