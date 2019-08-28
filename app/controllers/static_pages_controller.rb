class StaticPagesController < ApplicationController
  before_action :load_home

  def home
    @tours = Tour.tour_by_category(Settings.category_default)
    if params[:id_category]
      @tours = Tour.tour_by_category(params[:id_category])
    end
  end

  def search
    search = params[:search]
    byebug
    @tours = Tour.where("title like ? and price >= ? and price <= ?", "%#{search[:name]}%", search[:price_from], search[:price_to]).
      paginate(page: params[:page], per_page: Settings.per_page)
    render "home"
  end

  def contact; end

  def about; end

  def notfound; end

  private 
  def load_home
    @slides = Slide.all
    @categories = Category.category_tour
  end
end
