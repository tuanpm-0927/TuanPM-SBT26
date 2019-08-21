# frozen_string_literal: true

class Tour < ApplicationRecord
  belongs_to :category
  has_many :users, through: :userbooktours
  has_many :tourratings
end
