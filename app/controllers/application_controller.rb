# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionHelper
  include Pundit
  protect_from_forgery
end
