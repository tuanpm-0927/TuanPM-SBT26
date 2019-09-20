# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  scope :order_by_newest, -> { order(created_at: :desc) }
  scope :post_by_category, -> (id_category) { where(category_id: id_category )}

  ransack_alias :post, :title_or_content
end
