class StoreFavorite < ApplicationRecord
  belongs_to :follower, class: 'Store'
  belongs_to :followed, class: 'Store'
end
