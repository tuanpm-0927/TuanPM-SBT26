# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionHelper
  protect_from_forgery
end
