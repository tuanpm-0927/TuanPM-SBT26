class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, only: [:edit, :update]

  def new; end

  def edit; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".email_reset"
      redirect_to root_url
    else
      flash.now[:danger] = t ".email_not_found"
      render :new
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t(".error_empty"))
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t ".reset_password_success"
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def load_user
    @user = User.find_by(email: params[:email])
    return if @user
    flash[:warning] = t ".errors.user_notfound"
    redirect_to notfound_path
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])
    redirect_to root_url
  end
end
