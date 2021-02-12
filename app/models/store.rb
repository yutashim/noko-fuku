class Store < ApplicationRecord
  # before_validation :ensure_postcode
  has_many :user_favorites
  has_many :comments
  has_many :promotions
  has_many :active_follows, foreign_key: 'follower_id', class_name: 'StoreFavorite', dependent: :destroy
  has_many :passive_follows, foreign_key: 'followed_id', class_name: 'StoreFavorite', dependent: :destroy
  has_many :following_stores, through: :active_follows, source: :followed

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { maximum: 255 }
  validates :postcode, length: { is: 7 }
  has_secure_password

  private
  #以下の処理はparamsで受け取った直後に実行
  #カラムに代入するときに.to_iメソッドが働くから
  # def ensure_postcode
  #   puts postcode
  #   if postcode =~ /^\d{3}-?\d{4}$/
  #     puts postcode
  #     postcode.gsub!(/^(\d{3})-?(\d{4})$/, '\1\2')
  #   end
  # end
end
