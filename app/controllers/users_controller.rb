# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, except: %i[new create]
  before_action :correct_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".signup_success"
      redirect_to root_path
    else
      render :new
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:fullname, :email, :password,
                                 :password_confirmation, :birthday)
  end

  def load_user
    @user = User.find_by(id: params[:id])
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
