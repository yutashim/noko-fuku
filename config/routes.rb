Rails.application.routes.draw do
  get '/home', to: 'sessions#home'
  get '/', to: 'sessions#new_guest_login'
  resources :sessions, only: [:new, :create, :destroy]
  get '/store_login', to: 'sessions#store_login'
  get '/user_guest', to: 'sessions#user_guest_login'
  get '/store_guest', to: 'sessions#store_guest_login'
  resources :stores do
    get '/mypage', to: 'stores#mypage'
    resources :comments
    resources :promotions
  end
  resources :user_favorites, only: [:create, :destroy]
  resources :store_favorites, only: [:create, :destroy]
  resources :users
end
