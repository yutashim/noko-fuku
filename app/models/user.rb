class User < ApplicationRecord
  has_many :user_favorites
  has_many :comments
end
