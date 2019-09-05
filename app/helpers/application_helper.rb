# frozen_string_literal: true

module ApplicationHelper
  include SessionHelper
  
  def admin?
    return true if current_user && current_user.admin?
  end

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

  def check_first(images,image)
    return true if images.first == image
  end

  def show_image_tour(tour)
    return image_tag(tour.images[0].image_link.url, height: Settings.height_minium,
       width: Settings.width_minium) unless tour.images.empty?
  end
end
