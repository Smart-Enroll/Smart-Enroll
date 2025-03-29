class SessionsController < ApplicationController
    def new
    end
  
    def create
        student = Student.find_by(email: params[:email])
        
        if student.nil?
          flash[:alert] = "No account found with that email"
          redirect_to login_path and return
        end
      
        if student.authenticate(params[:password])
          session[:student_id] = student.id
          redirect_to dashboard_path, notice: "Successfully logged in!"
        else
          flash[:alert] = "Invalid password"
          render :new
        end
      end
  
    def destroy
      session[:student_id] = nil
      redirect_to root_path, notice: "Logged out successfully"
    end
  end