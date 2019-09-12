# frozen_string_literal: true

class Booking < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :informationbooktour
  belongs_to :user
  belongs_to :tourdetail
  has_one :payment, dependent: :destroy
  enum status: {paying: 0, paid: 1, done: 2}

  scope :order_by_newest, -> { order(created_at: :desc) }
  scope :query_by_tourdetail, -> (id) { where(tourdetail_id: id) }
  scope :select_revenue_all_month, -> { group_by_month(:created_at, format: Settings.format_day).
    sum(:total_money) }

  ransack_alias :booking,
   :user_fullname_or_user_phonenumber_or_informationbooktour_fullname_or_informationbooktour_phonenumber_or_tourdetail_tour_title
end
