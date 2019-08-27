# frozen_string_literal: true

module ApplicationHelper
  def full_title page_title 
    base_title = I18n.t(".layouts.application.title_page")
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def load_address
    address = Array.new
    File.open("address.txt", "r") do |file|
      file.each{ |line| address << line.split("\n") }
    end
    return address
  end
end
