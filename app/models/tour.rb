# frozen_string_literal: true

class Tour < ApplicationRecord
  belongs_to :category
  has_many :ratings
  has_many :tourdetails, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  scope :orderby, -> { order(created_at: :desc) }
  scope :tour_by_category, -> (id_category) { where(category_id: id_category )}
  before_save :calculator_price_discount
  validates :category_id, presence: :true

  def calculator_price_discount
    self.price_discount = self.price - self.price * (self.discount / 100 )
  end

end
