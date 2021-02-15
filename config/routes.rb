Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  get '/store_login', to: 'sessions#store_login'
  resources :stores do
    resources :comments
    resources :promotions
  end
  resources :user_favorites, only: [:create, :destroy]
  resources :store_favorites, only: [:create, :destroy]
  resources :users
end
