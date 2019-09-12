# frozen_string_literal: true

class Tour < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :tourdetails, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  scope :order_by_newest, -> { order(created_at: :desc) }
  scope :tour_by_category, -> (id_category) { where(category_id: id_category )}
  before_save :calculator_price_discount
  before_update :calculator_price_discount
  validates :category_id, presence: :true

  ransack_alias :tour, :title_or_content
  
  def calculator_price_discount
    self.price_discount = self.price - self.price * (self.discount / 100 )
  end

  class << self
    def tour_most_booking
      joins(:tourdetails).select("tours.*, sum(tourdetails.total_current_booking) as total_booking").
        group("tourdetails.tour_id").order("total_booking DESC")
    end
  end

  def is_booking_tour
    tourdetails.each do |tourdetail|
      return true if tourdetail.total_current_booking > 0
    end
  end
end
