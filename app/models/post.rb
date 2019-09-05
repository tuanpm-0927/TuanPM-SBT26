# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes
  has_many :comments
  scope :order_new, -> { order(created_at: :desc) }

  validates :category_id, presence: :true
  validates :user_id, presence: :true
end
