# frozen_string_literal: true

class Informationbooktour < ApplicationRecord
  acts_as_paranoid

  has_one :booking, dependent: :destroy
end
