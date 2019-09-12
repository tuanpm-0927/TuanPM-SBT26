class UsersController < ApplicationController
  load_and_authorize_resource
  
  before_action :load_user, only: :show

  def recharge
    coupon_input = params[:recharge][:coupon]
    if coupon = Coupon.find_by(coupon: coupon_input)
      if coupon.active
        current_user.update_attribute(:money, current_user.money + coupon.value)
        coupon.update_attribute(:active, false)
        flash[:success] = t ".recharge_success"
      else  
        flash[:danger] = t ".counpon_used"
      end
    else
      flash[:danger] = t ".coupon_notfound"
    end
    redirect_to user_path(current_user)
  end

  def show 
  end

  def booking
    @bookings = current_user.bookings.order_by_newest.paginate page: params[:page], per_page: Settings.per_page
    return if current_user
    flash[:danger] = ".notfound_user"
    redirect_to notfound_path
  end

  def payment_history
    @bookings = current_user.bookings.paid.order_by_newest.paginate page: params[:page], per_page: Settings.per_page
  end
  
  private

  def load_user
    @user = User.find_by(id: params[:id])
    return if @user
    flash[:danger] = t ".user_notfound"
    redirect_to notfound_path
  end
end
