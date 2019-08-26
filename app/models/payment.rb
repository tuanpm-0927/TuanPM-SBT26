# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :booking
  has_many :bankings, through: :paymentbankings
end
