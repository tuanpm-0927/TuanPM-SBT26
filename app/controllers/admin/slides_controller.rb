class Admin::SlidesController < ApplicationController
  before_action :load_slide, except: [:index, :create, :new]

  def index
    @slides = Slide.order_by_newest.paginate page: params[:page], per_page: Settings.def_perpage
  end

  def create 
    @slide = Slide.new slide_params
    if @slide.save
      load_slides
    end
    respond_to do |format|
      format.js
    end
  end

  def new
    @slide = Slide.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @check_update = @slide.update_attributes(slide_params)
      flash[:success] = t ".slide_update_success"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @slide.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admin_slides_path
  end

  private
  def slide_params
    params.require(:slide).permit(:name, :image)
  end

  def load_slide
    @slide = Slide.find_by(id: params[:id])
    return if @slide
    flash.now[:danger] = t ".slide_notfound"
    redirect_to notfound_path
  end
end
