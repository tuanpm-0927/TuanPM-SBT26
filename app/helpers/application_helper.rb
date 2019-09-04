# frozen_string_literal: true

module ApplicationHelper
  include SessionHelper
  
  def full_title page_title 
    base_title = I18n.t(".layouts.application.title_page")
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def check_empty(values)
    return false if values.empty?
    true
  
  def load_address
    address = Array.new
    File.open("address.txt", "r") do |file|
      file.each{ |line| address << line.split("\n") }
    end
    return address
  end

  def check_currentuser(user_id)
    return true if current_user&.id == user_id
  end
end
