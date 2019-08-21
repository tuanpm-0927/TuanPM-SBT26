# frozen_string_literal: true

class Userbooktour < ApplicationRecord
  belongs_to :informationbooktour
  belongs_to :user
  belongs_to :tour
end
