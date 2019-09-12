class PaymentsController < ApplicationController
  include ChatworkHelper

  before_action :load_payment, :load_booking, only: [:edit]

  def create
    money_payment = load_money_payment
    unless current_user.check_money(money_payment)
      flash[:danger] = t ".please_recharge_money"
    else
      payment = Payment.where(booking_id: @booking.id).first_or_create(params_payment)
      if payment.save
        payment.generate_code
        payment.send_payment_email(current_user)
        flash[:success] = t ".confirm_email_to_payment"
      else
        flash[:danger] = t ".payment_error"
      end
    end
    redirect_to userbooking_path
  end

  def edit
    ActiveRecord::Base.transaction do
      if @payment.authenticated?("payment", params[:id])
        @payment.paid!
        @booking.paid!
        
        flash[:success] = t ".confirm_success"
      else
        flash[:danger] = t ".payment_failed"
      end
      rescue ActiveRecord::RecordInvalid => exception
        flash[:danger] = t ".booking_failed"
    end
    redirect_to userbooking_path
  end

  private
  def load_money_payment
    @booking = Booking.find_by(id: params[:booking_id])
    unless @booking
      flash[:danger] = t ".booking_notfound"
      redirect_to root_path
    end
    tour = @booking.tourdetail.tour
    return tour.price_discount
  end

  def load_payment
    @payment = Payment.find_by(id: params[:payment_id])
    return if @payment
    flash[:danger] = t ".payment_notfound"
    redirect_to notfound_path
  end

  def load_booking
    @booking = Booking.find_by(id: @payment.booking_id)
    return if @booking
    flash[:danger] = t ".booking_notfound"
    redirect_to notfound_path
  end

  def params_payment
    {amount: @booking.tourdetail.tour.price_discount, booking_id: @booking.id}
  end
end
