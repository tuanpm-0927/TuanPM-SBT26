class Coupon < ApplicationRecord
  validates :coupon, presence: true,uniqueness: { case_sensitive: false }
end
