class Image < ApplicationRecord
  belongs_to :Tour, optional: true
  mount_uploader :image_link, ImageUploader
end
