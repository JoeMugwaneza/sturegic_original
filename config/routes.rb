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

  # designs
  get "application1" => "designs#application1" 

  get "application2" => "designs#application2" 
  get "studentprofile1" => "designs#studentprofile1"
  get "studentprofile2" => "designs#studentprofile2"

  get "application2" => "designs#application2"

  get "bonus" => "designs#index"
  get "studentprofile" => "designs#studentprofile"


end
