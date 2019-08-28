class StaticPagesController < ApplicationController


  def home
    @slides = Slide.all
    @categories = Category.all
  end

  def search; end

  def contact; end

  def about; end

  def notfound; end
end
