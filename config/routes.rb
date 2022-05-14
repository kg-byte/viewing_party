# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get 'users/:id/discover', to: 'users#discover'
  resources :users, only: %i[new index show create] do
    resources :movies, only: %i[index show] do
      resources :viewing_party, only: %i[new create]
    end
  end

  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create', as: 'log_in'
  delete 'logout', to: 'sessions#destroy'
  # get 'password', to: 'passwords#edit', as: 'edit_password'
  # patch 'password', to: 'passwords#update'
  # get 'password/reset', to: 'password_resets#new'
  # post 'password/reset', to: 'password_resets#create'
  # get 'password/reset/edit', to: 'password_resets#edit'
  # patch 'password/reset/edit', to: 'password_resets#update'
end
