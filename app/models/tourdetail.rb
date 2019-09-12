# frozen_string_literal: true

class Tourdetail < ApplicationRecord
  acts_as_paranoid

  belongs_to :tour
  has_one :booking, dependent: :destroy
  scope :order_early_current, -> { order(day_start: :asc)}
  scope :day_early_current, -> { where("day_start >= ?", Time.now) }
  validates :total_booking, presence: true, length: {minimum: Settings.minimun}
  validates :total_current_booking, presence: true, length: {minimum: Settings.minimun}
  validates :day_start, presence: true
  validate do
    day_start_large_than_day_current
  end

  def check_booking
    return true if total_current_booking < total_booking
    false
  end

  class << self
    def tour_most_booking
      select("tours.*, sum(tourdetail.id) as sum_booking").joins(:tours)
        .group("tours.id").order("sum_booking DESC")
    end
  end

  private 
  def day_start_large_than_day_current
    return if day_start.nil? || day_start >= Time.now
    errors.add(:day_start, "day start valid")
  end
end
