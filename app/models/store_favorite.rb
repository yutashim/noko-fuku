class StoreFavorite < ApplicationRecord
  belongs_to :follower, class_name: 'Store'
  belongs_to :followed, class_name: 'Store'
end
