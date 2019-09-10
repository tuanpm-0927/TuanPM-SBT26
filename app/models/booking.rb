# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :informationbooktour
  belongs_to :user
  belongs_to :tourdetail

  enum status: {paying: 0, paid: 1}
end
