Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboards#index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :users
  resources :sessions


  resources :student_infos
    get 'student_infos/new/confirm_email'


  # designs
  get "application1" => "designs#application1" 
  get "application2" => "designs#application2" 

end
