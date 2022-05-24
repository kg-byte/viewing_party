# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  delete 'users/:user_id/parties/:party_id', to: 'party_users#destroy'
  get 'dashboard/discover', to: 'users#discover'

  resource :dashboard, only: %i[:new show create], controller: :users do 
    resources :friendships, only: %i[create]
    resources :movies, only: %i[index show] do
      resources :viewing_party, only: %i[new create destroy]
    end
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    get '/users/:id', to: 'users#show'
    delete '/viewing_party/:id', to:'viewing_party#destroy'
  end

  get 'register', to: 'users#new'
  get 'login', to: 'sessions#login_form'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
