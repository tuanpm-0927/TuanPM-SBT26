# frozen_string_literal: true

class Category < ApplicationRecord
  enum typeposts: { Admin: 0, User: 1 }
  validates :name, presence: true
  mount_uploader :image, UploadUploader
end
