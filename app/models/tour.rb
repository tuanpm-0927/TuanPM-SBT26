# frozen_string_literal: true

class Tour < ApplicationRecord
  belongs_to :category
  has_many :users, through: :bookings
  has_many :ratings
end
