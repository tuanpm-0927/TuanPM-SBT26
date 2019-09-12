# frozen_string_literal: true

class Payment < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :booking
  has_many :bankings, through: :paymentbankings

  enum status: {paying: 0, paid: 1}

  def generate_code
    self.payment_code = Payment.new_token
    update_attribute(:payment_digest, Payment.digest(payment_code))
  end
  
  def send_payment_email(user)
    PaymentMailer.payment_confirm(self, user).deliver_now
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false unless digest
    BCrypt::Password.new(digest).is_password?(token)
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
              BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end
end
