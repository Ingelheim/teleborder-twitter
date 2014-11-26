Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  
  root 'application#index'

  namespace :api, defaults: {format: :json} do
    resources :tweets, only: [:index]
    resources :followers, only: [:index]
  end
end
