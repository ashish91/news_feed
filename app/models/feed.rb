class Feed < ApplicationRecord
  belongs_to :user
  belongs_to :creator, class_name: 'User'
  belongs_to :post

  scope :latest, -> { includes(:creator, :post).limit(10) }
end
