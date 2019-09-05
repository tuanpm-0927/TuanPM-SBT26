class PaymentsController < ApplicationController
  def create
    money_payment = load_money_payment
    unless current_user.check_money(money_payment)
      flash[:danger] = t ".please_recharge_money"
    else
      payment = Payment.new(params_payment)
      if payment.save
        @booking.paid!
        if current_user.update_attribute(:money, current_user.money - payment.amount) && @booking.save
          flash[:success] = t ".payment_success"
        else
          flash[:danger] = t ".error_payment"
        end
      else
        flash[:danger] = t ".payment_error"
      end
    end
    redirect_to userbooking_path
  end

  private
  def load_money_payment
    @booking = Booking.find_by(id: params[:booking_id])
    unless @booking
      flash[:danger] = ".booking_notfound"
      redirect_to root_path
    end
    tour = @booking.tourdetail.tour
    return tour.price_discount
  end

  def params_payment
    {amount: @booking.tourdetail.tour.price_discount, booking_id: @booking.id}
  end
end
