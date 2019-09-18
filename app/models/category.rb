# frozen_string_literal: true

class Category < ApplicationRecord
  enum type_post: { admin: 0, user: 1 }
  validates :name, presence: true, length: { maximum: Settings.length_max_category_name }
  mount_uploader :image, ImageUploader
  scope :order_by_newest, -> { order(created_at: :desc) }

  has_many :tours, dependent: :destroy 
end
