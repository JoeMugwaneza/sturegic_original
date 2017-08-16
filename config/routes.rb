Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  default_url_options :host => "stregic.herokuapp.com"
  
  root 'designs#admindashboard1'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :sessions
  resources :student_infos
  resources :users
  resources :password_resets

  get 'users/:token/confirm_email/', :to => "users#confirm_email", as: 'confirm_email'

  get 'students/:id', to: 'users#show', as: 'student'
  get 'admins/:id', to: 'users#show', as: 'admin'
  get 'admins/:id/profile-one', to: 'profiles#profile_one', as: 'admin_profile'

  get 'students/:id/profile-one', to: 'profiles#profile_one', as: 'student_profile_one'

  get 'students/:id/profile-two', to: "profiles#profile_two", as: 'student_profile_two'

  get 'students/:id/user_edit', to: 'profiles#user_edit'
  get 'students/:id/student_edit', to: 'profiles#student_edit'


  get "application1" => "designs#application1" 

  get "application2" => "designs#application2" 
  # get "studentprofile1" => "designs#studentprofile1"
  # get "studentprofile2" => "designs#studentprofile2"
  get "admin" => "designs#admin"
  get "agent" => "designs#agent"

  get "application2" => "designs#application2"

  get "bonus" => "designs#index"
  get "studentprofile" => "designs#studentprofile"

  get "dashboard" => "designs#admindashboard1"
  get "/paymentarchive" => "designs#paymentarchive"
end
