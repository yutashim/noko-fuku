class User < ApplicationRecord
  has_many :user_favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_stores, through: :user_favorites, source: :store

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :password, presence: true, length: { maximum: 255 }
  before_validation { email.downcase! if email.present? }
  has_secure_password
end
