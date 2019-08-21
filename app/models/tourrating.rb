# frozen_string_literal: true

class Tourrating < ApplicationRecord
  belongs_to :tour
  belongs_to :user
end
