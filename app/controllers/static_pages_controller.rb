class StaticPagesController < ApplicationController
  def home
    @slides = Slide.all
    @categories = Category.all
    @tours = Tour.tour_by_category(Settings.category_default)
    if params[:id_category]
      @tours = Tour.tour_by_category(params[:id_category])
    end
  end

  def search; end

  def contact; end

  def about; end

  def notfound; end
end
