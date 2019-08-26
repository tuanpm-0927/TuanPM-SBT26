# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tours, through: :bookings
  has_many :posts
  enum admin: [:admin, :user]
end
