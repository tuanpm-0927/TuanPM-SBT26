class SessionController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      check_activate user
      params[:session][:remember_me] == Settings.checkbox_true ? remember(user) : forget(user)
      redirect_to admin_path if user.admin?
      redirect_to root_path unless user.admin?
    else
      flash.now[:danger] = t ".login_failed"
      render :new
    end
  end

  def destroy
    byebug
    log_out if logged_in?
    redirect_to root_path unless logged_in?
  end

  private
  def check_activate user
    if user.activated?
      log_in user
      flash[:success] = t ".login_success"
    else
      flash[:warning] = t ".message"
    end
  end
end
