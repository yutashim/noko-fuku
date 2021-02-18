Rails.application.routes.draw do
  get '/', to: 'sessions#home'
  resources :sessions, only: [:new, :create, :destroy]
  get '/store_login', to: 'sessions#store_login'
  resources :stores do
    get '/mypage', to: 'stores#mypage'
    resources :comments
    resources :promotions
  end
  resources :user_favorites, only: [:create, :destroy]
  resources :store_favorites, only: [:create, :destroy]
  resources :users
end
