# frozen_string_literal: true

module Admin::ToursHelper
  def load_categories
    Category.load_categories_admin(Settings.admin)
  end

  def check_address_present(tour)
    unless tour.address_source.nil?
      tour.address_source.split("\r\n")
    else
      ""
    end
  end

  def check_current_tour(tour)
    day_tours = tour.start_days.split("|").collect{|i| i.to_i}
    time_now = Time.now
    day_now = time_now.day
    day_tours.each do |day_tour|
      if day_tour >= day_now
        return "#{day_tour}/#{time_now.month}/#{time_now.year}"
      end
    end
    "#{day_tour}/#{time_now.month + 1}/#{time_now.year}"
  end
end
