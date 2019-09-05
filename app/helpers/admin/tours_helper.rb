# frozen_string_literal: true

module Admin::ToursHelper
  def load_categories
    Category.admin.collect{ |u| [u.name, u.id] }
  end

  def load_categories_user
    Category.user.collect{ |u| [u.name, u.id] }
  end

  def check_address_present(tour)
    unless tour.address_source.nil?
      tour.address_source.split("\r\n")
    else
      ""
    end
  end
end
