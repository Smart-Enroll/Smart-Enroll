class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  def index
    @students = Student.all
    respond_to do |format|
      format.html
    end
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
      redirect_to @student, notice: 'Student was successfully created.'
    else
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

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :email, :credits_earned, :password, :password_confirmation)
  end
end
