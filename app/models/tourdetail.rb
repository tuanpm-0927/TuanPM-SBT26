# frozen_string_literal: true

class Tourdetail < ApplicationRecord
  belongs_to :tour
  scope :order_early_current, -> { order(day_start: :asc)}
  scope :day_early_current, -> { where("day_start >= ?", Time.now) }
  
  validates :total_booking, presence: true, length: {minimum: Settings.minimun}

  def check_booking
    return true if total_current_booking < total_booking
    false
  end
end
