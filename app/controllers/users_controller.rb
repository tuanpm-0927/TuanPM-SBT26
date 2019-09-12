class UsersController < ApplicationController
  before_action :load_user, only: %i[show destroy]
  before_action :correct_user, only: :destroy

  def index
    @user = User.paginate(page: params[:page], per_page: Settings.per_page)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_mail"
      redirect_to root_path
    else
      render :new
    end
  end

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

  def show; end

  def destroy 
    if @user.destroy
      flash[:success] = t ".delete_success"
      redirect_to users_path
    else
      flash[:danger] = t ".delete_error"
      redirect_to not_found
    end
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
  def user_params
    params.require(:user).permit(:fullname, :email, :password,
      :password_confirmation, :birthday)
  end

  def load_user
    @user = User.find_by(id: params[:id])
    return if @user
    flash[:danger] = t ".user_notfound"
    redirect_to notfound_path
  end

  def correct_user
    redirect_to root_url unless current_user?@user
  end
end
