Rails.application.routes.draw do
  # Root path
  root "home#index"  # Sets the home page to the index action of HomeController

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
      get 'enroll'  # Custom route for enrolling in a course
    end
  end
  resources :schedule_view, only: [:index]  # Restrict to index action
  resources :admins
  get 'students/:id/edit_password', to: 'students#edit_password', as: 'edit_password'
  patch 'students/:id/update_password', to: 'students#update_password', as: 'update_password'

  delete '/courses/:id/unenroll', to: 'courses#unenroll', as: 'unenroll_course'
  get '/students/:id', to: 'students#show', as: 'student_profile'

  # Future PWA support (commented for now)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
