# frozen_string_literal: true

class Post < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :user
  belongs_to :category
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  scope :order_by_newest, -> { order(created_at: :desc) }
  scope :post_by_category, -> (id_category) { where(category_id: id_category )}
  validates :category_id, presence: :true
  validates :user_id, presence: :true

  ransack_alias :post, :title_or_content
end
