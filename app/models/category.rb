# frozen_string_literal: true

class Category < ApplicationRecord
  enum type_post: { Admin: 0, User: 1 }
  validates :name, presence: true
  mount_uploader :image, UploadUploader
  scope :orderby, -> { order(created_at: :desc) }
  scope :load_categories_admin, -> { where(type_post: Category.Admin) }

  has_many :tours, dependent: :destroy 
  # Ex:- scope :active, -> {where(:active => true)}
end
