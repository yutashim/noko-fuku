class User < ApplicationRecord
  has_many :user_favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_stores, through: :user_favorites, source: :store
end
