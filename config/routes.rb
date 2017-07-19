Rails.application.routes.draw do

  root 'dashboards#index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions

  resources :student_infos
    get 'student_infos/new/confirm_email'
end
