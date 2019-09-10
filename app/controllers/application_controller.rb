# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionHelper
  include Pundit
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def user_not_authorized
    flash[:alert] = t ".user_not_allow"
    redirect_to notfound_path
  end
end
