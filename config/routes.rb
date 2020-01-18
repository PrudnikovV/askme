Rails.application.routes.draw do

  get 'tags/show'
  root 'users#index'

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
  get 'destroy_user' => 'users#destroy'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new, :index]
  resources :tags, only: [:show]
end
