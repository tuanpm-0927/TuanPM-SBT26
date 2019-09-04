# frozen_string_literal: true

class Category < ApplicationRecord
  enum type_post: { admin: 0, user: 1 }
  validates :name, presence: true
  mount_uploader :image, UploadUploader
  scope :order_by_newest, -> { order(created_at: :desc) }

  has_many :tours, dependent: :destroy 
  # Ex:- scope :active, -> {where(:active => true)}
end
