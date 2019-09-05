class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  scope :order_by_newest, -> { order(created_at: :desc) }
end
