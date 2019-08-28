# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token
  enum admin: {admin: 0, user: 1}
  has_many :tours, through: :bookings
  has_many :posts
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save :downcase_email
  has_many :posts
  validates :fullname, presence: true, length: { maximum: Settings.length_max_name }
  validates :email, presence: true,uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: Settings.length_min_pass },
   allow_nil: true 
  validates :birthday, presence: true

  has_secure_password

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false unless digest
      BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end
    
    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
              BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

  private 
  def downcase_email
    email.downcase!
  end
end
