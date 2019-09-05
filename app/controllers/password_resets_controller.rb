class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, only: [:edit, :update]

  def new; end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t(".error_empty"))
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t ".reset_password_success"
      redirect_to @user
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

  # Confirms a valid user.
  def valid_user
    unless @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end
end
