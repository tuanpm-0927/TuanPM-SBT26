module SessionHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current
    current_user
  end

  def current_user?(user)
    user == current_user
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    forget current_user
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
