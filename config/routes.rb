FraudStarr::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'frauds#index'

  get 'report_fraud', to: 'frauds#register'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get '/passwords/confirmation', to: 'passwords#confirm', as: :password_confirmation
  get 'expired_token', to: 'password_resets#expired_token'

  namespace :admin do
    resources :fraud_types
  end

  resources :frauds, only: [:new, :create, :show] do
    collection do
      get 'search', to: 'frauds#search'
    end
  end

  resources :users
  resources :sessions, only: [:create]
  resources :passwords, only: [:new, :create]
  resources :password_resets, only: [:show]
end
