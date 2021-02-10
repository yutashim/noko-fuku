class Store < ApplicationRecord
  has_many :user_favorites
  has_many :comments
  has_many :promotions
  has_many :active_follows, foreign_key: 'follower_id', class_name: 'StoreFavorite', dependent: :destroy
  has_many :passive_follows, foreign_key: 'followed_id', class_name: 'StoreFavorite', dependent: :destroy
  has_many :following_stores, through: :active_follows, source: :followed
  has_secure_password
end
