class Store < ApplicationRecord
  # before_validation :ensure_postcode
  has_many :user_favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :promotions, dependent: :destroy
  has_many :active_follows, foreign_key: 'follower_id', class_name: 'StoreFavorite', dependent: :destroy
  has_many :passive_follows, foreign_key: 'followed_id', class_name: 'StoreFavorite', dependent: :destroy
  has_many :following_stores, through: :active_follows, source: :followed

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { maximum: 255 }
  # validates :postcode, length: { is: 7 }
  mount_uploader :icon, StoreIconUploader
  has_secure_password

end
