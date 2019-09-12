class User < ApplicationRecord
  devise :omniauthable, :database_authenticatable, :registerable, :confirmable, :recoverable,
    :omniauth_providers => [:facebook]
  include UsersHelper
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  enum admin: {admin: 0, user: 1}
  has_many :bookings
  has_many :posts, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :fullname, presence: true, length: { maximum: Settings.length_max_name }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: Settings.length_min_pass },
    allow_nil: true 

  #custom_validate
  validate do
    birthday_must_smaller_x_year
  end

  def check_money(money_payment)
    return true if money > money_payment
    false
  end
  
  class << self
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.fullname = auth.info.name
        user.skip_confirmation!
        user.save!
      end
    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] &&  session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end

  private   
  def confirmation_required?
    !confirmed?
  end

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
