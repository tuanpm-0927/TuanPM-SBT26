# frozen_string_literal: true

class Tour < ApplicationRecord
  belongs_to :category
  has_many :ratings
  has_many :tourdetails, dependent: :destroy
  scope :order_by_newest, -> { order(created_at: :desc) }
end
