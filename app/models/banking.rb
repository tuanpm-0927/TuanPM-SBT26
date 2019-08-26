# frozen_string_literal: true

class Banking < ApplicationRecord
  has_many :payments, through: :paymentbankings
end
