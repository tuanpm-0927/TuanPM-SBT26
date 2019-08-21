# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes
  has_many :commentposts
end
