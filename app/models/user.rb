# frozen_string_literal: true

class User < ApplicationRecord
  include UsersHelper
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  enum admin: {admin: 0, user: 1}
  has_many :bookings
  has_many :posts, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  has_secure_password
  validates :address, presence: true, length: { maximum: Settings.length_max_address }
  validates :fullname, presence: true, length: { maximum: Settings.length_max_name }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :phonenumber, presence: true, uniqueness: { case_sensitive: false },
    length: { maximum: Settings.length_max_phonenumber }
  validates :password, presence: true, length: { minimum: Settings.length_min_pass },
    allow_nil: true 
  validates :birthday, presence: true

  #custom_validate
  validate do
    birthday_must_smaller_x_year
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def check_money(money_payment)
    return true if money > money_payment
    false
  end

  def activate
    update_attributes activated: true
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false unless digest
    BCrypt::Password.new(digest).is_password?(token)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute :reset_digest, User.digest(reset_token)
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

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def birthday_must_smaller_x_year
    return if birthday.nil? || age(birthday) >= Settings.age_valid
    errors.add(:birthday, :birthday_invalid)
  end
end
