class Store < ApplicationRecord
  has_many :user_favorites
  has_many :comments
  has_many :promotions
  has_many :active_follow, foreign_key: 'follower_id', class_name: 'StoreFavorite', dependent: :destroy
  has_many :passive_follow, foreign_key: 'followed_id', class_name: 'StoreFavorite', dependent: :destory
  has_many :following_store, through: 'StoreFavorite', source: 'followed'
end
