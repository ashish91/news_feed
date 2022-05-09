class Feed < ApplicationRecord
  belongs_to :user
  belongs_to :creator, class_name: 'User'
  belongs_to :post
end
