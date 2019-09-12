# frozen_string_literal: true

class Like < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :user
  belongs_to :post
end
