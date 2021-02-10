Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  get '/store_login', to: 'sessions#store_login'

end
