class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  
  def index
    @courses = Course.all
  
    if params[:search].present?
      search_term = "%#{params[:search].downcase}%" 
      @courses = @courses.where("LOWER(class_name) LIKE ?", search_term)
    end
  
    if params[:recommended] == "true" && current_student
      @courses = @courses.where(major: current_student.major)
    end
  end
  
  def show
  end

  def new
    @course = Course.new
  end

  def enroll
    course = Course.find(params[:id])
    current_student = Student.find(session[:student_id]) # Ensure user is logged in

    # Check if the student is already enrolled
    if current_student.courses.include?(course)
      flash[:notice] = "You're already enrolled in this course!"
      redirect_to courses_path and return
    end

    # Check if the course has a prerequisite
    if course.prerequisite.present?
      # Get all completed courses for the student
      completed_courses = current_student.user_schedules.where(status: "Planned").pluck(:course_id)

      # Ensure the prerequisite course is completed
      prerequisite_course = Course.find_by(class_name: course.prerequisite)
      if prerequisite_course && !completed_courses.include?(prerequisite_course.id)
        flash[:alert] = "You cannot enroll in #{course.class_name} because you have not completed the prerequisite: #{course.prerequisite}."
        redirect_to courses_path and return
      end
    end

    # Enroll the student by creating a new UserSchedule entry
    UserSchedule.create!(
      student_id: current_student.id,
      course_id: course.id,
      term: course.term,
      status: "Planned"
    )

    flash[:notice] = "Successfully enrolled in #{course.class_name} for #{course.term}!"
    redirect_to courses_path
  end

  def unenroll
    course = Course.find(params[:id])
    current_student.courses.delete(course)
    redirect_to schedule_view_index_path, notice: "You have been unenrolled from #{course.class_name}."
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: 'Course was successfully deleted.'
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:CRN, :class_name, :professor, :term, :credits, :class_time, :prerequisite, :status)
  end
end
