Rails.application.routes.draw do
  # Admin dashboard routes
  get 'admins_dashboard', to: 'admins_dashboard#index', as: 'admins_dashboard_index'
  delete 'admins_dashboard/destroy_student/:id', to: 'admins_dashboard#destroy_student', as: 'destroy_student_admins_dashboard'
  delete 'admins_dashboard/destroy_course/:id', to: 'admins_dashboard#destroy_course', as: 'destroy_course_admins_dashboard'

  # Root path
  root "home#index"

  # Authentication routes
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout
  get "/dashboard", to: "students#dashboard", as: :dashboard

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Resourceful routes
  resources :students

  resources :courses do
    member do
      get 'enroll'
    end
  end

  resources :schedule_view, only: [:index]
  resources :admins

  get 'students/:id/edit_password', to: 'students#edit_password', as: 'edit_password'
  patch 'students/:id/update_password', to: 'students#update_password', as: 'update_password'

  delete '/courses/:id/unenroll', to: 'courses#unenroll', as: 'unenroll_course'
  get '/students/:id', to: 'students#show', as: 'student_profile'
end
