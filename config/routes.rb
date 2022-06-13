# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    get 'users/me', to: 'users#me'    
    resources :users
    
    post 'auth/login', to: 'authentication#login'
  end
end
