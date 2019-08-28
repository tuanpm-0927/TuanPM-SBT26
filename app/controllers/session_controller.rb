class SessionController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.checkbox_true ? remember(user) : forget(user)
      flash[:success] = t ".login_success"
      redirect_to root_path
    else
      flash.now[:danger] = t ".login_failed"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path unless logged_in?
  end
end
