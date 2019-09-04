# frozen_string_literal: true

class Tour < ApplicationRecord
  belongs_to :category
  has_many :ratings
  has_many :tourdetails, dependent: :destroy
<<<<<<< HEAD
=======
  before_save :calculator_price_discount

  validates :category_id, presence: :true

  def calculator_price_discount
    self.price_discount = self.price - self.price * (self.discount / 100 )
  end
>>>>>>> f7b4774776c5414cb77fbe080956f6ec341fc0cd
end
