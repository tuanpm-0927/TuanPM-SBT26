class Slide < ApplicationRecord
  validates :name, presence: true,
    length: { maximum: Settings.length_max_slidename }
  mount_uploader :image, ImageUploader
end
