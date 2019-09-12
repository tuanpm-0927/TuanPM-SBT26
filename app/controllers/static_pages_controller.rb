class StaticPagesController < ApplicationController
  layout :user_layout 

  def home
    if params[:commit].nil?
      @posts = Post.order_by_newest.paginate(page: params[:page], per_page: Settings.per_page)
      @tours = Tour.tour_most_booking.paginate(page: params[:page], per_page: Settings.per_page)
      @tours = Tour.tour_by_category(params[:id_category_tour]).
        paginate(page: params[:page], per_page: Settings.per_page) if params[:id_category_tour]
      @posts = Post.post_by_category(params[:id_category_post]).
        paginate(page: params[:page], per_page: Settings.per_page) if params[:id_category_post]
    else
      title_cont = params[:name]
      @posts = Post.ransack({title_cont: title_cont}).result
      @tours = Tour.ransack({price_discount_gteq: params[:price_from],
        price_discount_lteq: params[:price_to], title_cont: title_cont}).result
    end
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

  def contact; end

  def about; end

  def notfound; end

  private 
  def user_layout
    return "admin" if current_user&.admin?
    "application"
  end
end
