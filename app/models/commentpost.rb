# frozen_string_literal: true

class Commentpost < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
