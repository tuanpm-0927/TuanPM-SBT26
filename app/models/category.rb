# frozen_string_literal: true

class Category < ApplicationRecord
  enum type_post: { Admin: 0, User: 1 }
  validates :name, presence: true
  mount_uploader :image, UploadUploader
  scope :orderby, -> { order(created_at: :desc) }
  scope :load_categories_admin, -> (type_post) { where(type_post: type_post) }
  scope :category_tour, -> { where(type_post: :Admin)}
  scope :category_post, -> { where(type_post: :User)}

  has_many :tours, dependent: :destroy 
  # Ex:- scope :active, -> {where(:active => true)}
end
