# frozen_string_literal: true

class Tour < ApplicationRecord
  belongs_to :category
  has_many :users, through: :bookings
  has_many :ratings
  before_save :calculator_price_discount

  validates :category_id, presence: :true

  def calculator_price_discount
    self.price_discount = self.price - self.price * (self.discount / 100 )
  end
end
