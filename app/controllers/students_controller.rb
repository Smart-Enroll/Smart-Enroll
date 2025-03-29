class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:dashboard]
  #Student Controller
  # GET /students
  def index
    @students = Student.all
    respond_to do |format|
      format.html
    end
  end

  def dashboard
    @student = Student.find(session[:student_id])
  end


  # GET /students/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /students/new
  def new
    @student = Student.new
    respond_to do |format|
      format.html
    end
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    if @student.save
      # Redirect to the login page (or root path if that's where your login is)
      redirect_to root_path , notice: 'Student was successfully created. Please log in.'
    else
      # Render the 'new' form again if there are errors
      render :new
    end
  end
  # GET /students/:id/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # PATCH/PUT /students/:id
  def update
    if @student.update(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /students/:id
  def destroy
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully removed.'
  end

  private

  def require_login
    unless session[:student_id]
      redirect_to login_path, alert: "You must be logged in to access the dashboard"
    end
  end
  
  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :email, :credits_earned, :password, :password_confirmation)
  end
end
