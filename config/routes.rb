FraudStarr::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'frauds#index'

  get 'report_fraud', to: 'frauds#register'
  get 'register', to: 'users#new'
  # get 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'

  namespace :admin do
    resources :fraud_types
  end

  resources :frauds, only: [:new, :create, :show] do
    collection do
      get 'search', to: 'frauds#search'
    end
  end

  resources :users, only: [:create]
  resources :sessions, only: [:create]
end
