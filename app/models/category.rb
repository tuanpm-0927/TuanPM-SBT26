# frozen_string_literal: true

class Category < ApplicationRecord
  enum type_post: { admin: 0, user: 1 }
  validates :name, presence: true
  mount_uploader :image, ImageUploader
  scope :order_by_newest, -> { order(created_at: :desc) }
  scope :load_categories_admin, -> { where(type_post: :Admin) }
  scope :category_tour, -> { where(type_post: :Admin)}
  scope :category_post, -> { where(type_post: :User)}

  has_many :tours, dependent: :destroy 
  # Ex:- scope :active, -> {where(:active => true)}
end
