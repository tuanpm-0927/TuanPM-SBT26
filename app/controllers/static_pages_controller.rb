class StaticPagesController < ApplicationController
  layout :user_layout 
  before_action :load_default, :load_home, only: [:home, :search]

  def home
    if params[:id_category_tour]
      @tours = Tour.tour_by_category(params[:id_category_tour]).
        paginate(page: params[:page], per_page: Settings.per_page)
    elsif params[:id_category_post]
      @posts = Post.post_by_category(params[:id_category_post]).
        paginate(page: params[:page], per_page: Settings.per_page)
    end
  end

  def admin_home; end

  def search
    search = params[:search]
    @tours = Tour.where("title like ? and price >= ? and price <= ?", "%#{search[:name]}%", search[:price_from], search[:price_to]).
      paginate(page: params[:page], per_page: Settings.per_page)
    @posts = Post.where("title like ?", "%#{search[:name]}%").
      paginate(page: params[:page], per_page: Settings.per_page)
    render "home"
  end

  def contact; end

  def about; end

  def notfound; end

  private 
  def load_home
    @slides = Slide.all
    @category_tours = Category.admin
    @category_posts = Category.user
  end

  def load_default
    @tours = Tour.order_by_newest.paginate(page: params[:page], per_page: Settings.per_page)
    @posts = Post.order_by_newest.paginate(page: params[:page], per_page: Settings.per_page)
  end

  def user_layout
    return "admin" if current_user&.admin?
    "application"
  end
end
