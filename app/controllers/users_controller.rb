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
      log_in @user
      flash[:success] = t ".signup_success"
      redirect_to root_path
    else
      render :new
    end
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
