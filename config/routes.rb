FraudStarr::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get 'register_fraud', to: 'frauds#register'

  namespace :admin do
    resources :fraud_types
  end

  resources :frauds, only: [:new, :create]
end
