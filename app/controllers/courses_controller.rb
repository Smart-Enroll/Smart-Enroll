class CoursesController < ApplicationController
    before_action :set_course, only: %i[show edit update destroy]
  
    def index
      @courses = Course.all
    
      if params[:recommended] == "true" && current_student
        @courses = @courses.where(major: current_student.major)
      end
    end
    
    def show
    end
  
    def new
      @course = Course.new
    end
  
    # def enroll
    #   course = Course.find(params[:id])
    #   current_student = Student.find(session[:student_id])  # Ensure user is logged in
    
    #   if current_student.courses.include?(course)
    #     flash[:notice] = "You're already enrolled in this course!"
    #   else
    #     current_student.courses << course
    #     flash[:notice] = "Successfully enrolled in #{course.class_name}!"
    #   end
      
    #   redirect_to courses_path
    # end

    def enroll
      course = Course.find(params[:id])
      current_student = Student.find(session[:student_id])  # Ensure user is logged in
      
      # Check if the student is already enrolled in the course
      if current_student.courses.include?(course)
        flash[:notice] = "You're already enrolled in this course!"
      else
        # Enroll the student in the course
        current_student.courses << course
        # Optionally, set status if you need to manually insert the status in the join table
        user_schedule = current_student.user_schedules.find_by(course: course)
        user_schedule.update(status: "Planned") if user_schedule
        flash[:notice] = "Successfully enrolled in #{course.class_name}!"
      end
      
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
      params.require(:course).permit(:CRN, :class_name, :professor, :term, :credits, :class_time)
    end
  end
  