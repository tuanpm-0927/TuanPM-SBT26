# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :tour
  belongs_to :user
end
