# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes
  has_many :comments
  scope :order_by_newest, -> { order(created_at: :desc) }
  scope :post_by_category, -> (id_category) { where(category_id: id_category )}

  validates :category_id, presence: :true
  validates :user_id, presence: :true
end
