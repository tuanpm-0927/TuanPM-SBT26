# frozen_string_literal: true

module Admin::ToursHelper
  def load_categories
    Category.where("type_post = ?", "Admin")
  end

  def check_address_present(tour)
    unless tour.address_source.nil?
      tour.address_source.split("\r\n")
    else
      ""
    end
  end
end
