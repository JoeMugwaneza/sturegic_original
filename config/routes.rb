Rails.application.routes.draw do

  default_url_options :host => "stregic.herokuapp.com"
  
  root 'dashboards#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :sessions
  resources :student_infos
  resources :users
  resources :password_resets

  get 'users/:token/confirm_email/', :to => "users#confirm_email", as: 'confirm_email'

  get 'students/:id', to: 'users#show', as: 'student'

  get 'students/:id/profile-one', to: 'profiles#profile_one', as: 'student_profile_one'

  get 'students/:id/profile-two', to: "profiles#profile_two", as: 'student_profile_two'

  get 'students/:id/edit', to: 'profiles#edit'


  get "application1" => "designs#application1" 

  get "application2" => "designs#application2" 
  # get "studentprofile1" => "designs#studentprofile1"
  # get "studentprofile2" => "designs#studentprofile2"
  get "admin" => "designs#admin"
  get "agent" => "designs#agent"

  get "application2" => "designs#application2"

  get "bonus" => "designs#index"
  get "studentprofile" => "designs#studentprofile"

  get "admindashboard" => "designs#admindashboard"
end
