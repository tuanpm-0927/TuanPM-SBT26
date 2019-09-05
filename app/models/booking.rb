# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :informationbooktour
  belongs_to :user
  belongs_to :tourdetail
  has_one :payment, dependent: :destroy
  enum status: {paying: 0, paid: 1}

  scope :order_by_newest, -> { order(created_at: :desc) }
  scope :query_by_tourdetail, -> (id) { where(tourdetail_id: id) }
end
