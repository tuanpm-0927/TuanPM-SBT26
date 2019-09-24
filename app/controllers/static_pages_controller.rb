class StaticPagesController < ApplicationController
  def home
    @slides = Slide.all
  end

  def admin_home
    authorize! :read, :admin_home
    revenue_per_month = Booking.select_revenue_all_month
    @data = {
      labels: revenue_per_month.keys,
      datasets: [
        {
          label: t(".statistical"),
          backgroundColor: "rgba(220,220,220,0.2)",
          borderColor: "rgba(220,220,220,1)",
          data: revenue_per_month.values
        }
      ]
    }
    @options = {}
  end

  def search; end

  def contact; end

  def about; end

  def notfound; end
end
