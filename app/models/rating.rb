# frozen_string_literal: true

class Rating < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :tour
  belongs_to :user
end
