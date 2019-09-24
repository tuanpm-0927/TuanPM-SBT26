# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :config_permitted_parameters, if: :devise_controller?
  include SessionHelper

  private
  def config_permitted_parameters
    register_attrs = [:fullname, :phonenumber, :email, :password, :password_confirmation]
    update_attrs = [:fullname, :phonenumber, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: register_attrs
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end
end
