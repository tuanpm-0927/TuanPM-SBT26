# frozen_string_literal: true

class SessionController < ApplicationController
  before_action :logged_in_in?, only: :new
  before_action :correct_user, only: :destroy
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.checkbox_true ? remember(user) : forget(user)
      flash[:success] = t '.login_success'
      redirect_to root_path
    else
      flash.now[:danger] = t '.login_failed'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def logged_in_in?
    redirect_to root_path if logged_in?
  end

  def load_user
    @user = User.find_by(id: params[:id])
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
