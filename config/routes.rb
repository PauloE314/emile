# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :users do
      get '/me', on: :collection, to: 'users#me'
      get '/me/recipes', on: :collection, to: 'users#recipes'
      get '/me/favorites', on: :collection, to: 'users#favorites'
    end

    resources :recipes do
      post '/favorite', to: 'recipes#favorite', on: :member
      delete '/favorite', to: 'recipes#unfavorite', on: :member
    end

    post 'auth/login', to: 'authentication#login'
  end
end
