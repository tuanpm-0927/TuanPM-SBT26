# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  scope :order_new, -> { order(created_at: :desc) }
end
