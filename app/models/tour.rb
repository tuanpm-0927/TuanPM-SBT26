# frozen_string_literal: true

class Tour < ApplicationRecord
  belongs_to :category
  has_many :ratings
  has_many :tourdetails, dependent: :destroy
  before_save :calculator_price_discount

  validates :category_id, presence: :true

  def calculator_price_discount
    self.price_discount = self.price - self.price * (self.discount / 100 )
  end
end
