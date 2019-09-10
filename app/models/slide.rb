class Slide < ApplicationRecord
  mount_uploader :image, UploadUploader
  scope :order_by_newest, -> { order(created_at: :desc)}
  # Ex:- scope :active, -> {where(:active => true)}
end
