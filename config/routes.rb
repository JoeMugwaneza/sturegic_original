Rails.application.routes.draw do

  default_url_options :host => "stregic.herokuapp.com"
  
  root 'dashboards#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :sessions
  resources :student_infos 
  


  # designs
  get "application1" => "designs#application1" 
  get "application2" => "designs#application2" 

end
