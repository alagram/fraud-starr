FraudStarr::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'frauds#index'

  get 'register_fraud', to: 'frauds#register'

  namespace :admin do
    resources :fraud_types
  end

  resources :frauds, only: [:new, :create] do
    collection do
      get 'search', to: 'frauds#search'
    end
  end
end
