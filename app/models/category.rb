# frozen_string_literal: true

class Category < ApplicationRecord
  enum typeposts: { Admin: 0, User: 1 }
  validates :name, presence: true
  mount_uploader :image, UploadUploader
  scope :orderby, -> { order(created_at: :desc) }

  has_many :tours, dependent: :destroy 
  # Ex:- scope :active, -> {where(:active => true)}
end
