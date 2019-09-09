# frozen_string_literal: true

class Tour < ApplicationRecord
  belongs_to :category
  has_many :ratings
  has_many :tourdetails, dependent: :destroy
  scope :order_by_newest, -> { order(created_at: :desc) }
  before_save :calculator_price_discount
  mount_uploader :images, UploadUploader

  scope :tour_by_category, -> (id_category) { where(category_id: id_category )}

  def calculator_price_discount
    self.price_discount = self.price - self.price * (self.discount / 100 )
  end
end
