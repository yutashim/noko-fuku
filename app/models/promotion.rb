class Promotion < ApplicationRecord
  belongs_to :store

  validates :content, presence: true
end
