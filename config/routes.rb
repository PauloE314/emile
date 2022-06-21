# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    get 'users/me', to: 'users#me'
    get 'users/me/recipes', to: 'users#recipes'
    get 'users/me/favorites', to: 'users#favorites'

    resources :users

    resources :recipes do
      post '/favorite', to: 'recipes#favorite', on: :member
      delete '/favorite', to: 'recipes#unfavorite', on: :member
    end

    post 'auth/login', to: 'authentication#login'
  end
end
