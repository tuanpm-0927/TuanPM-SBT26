# frozen_string_literal: true

module Admin::ToursHelper
  def load_categories
    help = Category.load_categories_admin
  end

  def check_address_present(tour)
    unless tour.address_source.nil?
      tour.address_source.split("\r\n")
    else
      ""
    end
  end
end
