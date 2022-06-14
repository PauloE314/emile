# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    get 'users/me', to: 'users#me'

    resources :users
    resources :recipes do
      post '/favorite', to: 'recipes#favorite', on: :member
      delete '/favorite', to: 'recipes#unfavorite', on: :member
    end

    post 'auth/login', to: 'authentication#login'
  end
end
