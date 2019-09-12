class PaymentMailer < ApplicationMailer
  def payment_confirm payment, user
    @payment = payment
    @user = user
    mail to: user.email, subject: t(".subject")
  end
end
