class Admin::SlidesController < ApplicationController
  authorize_resource
  
  before_action :load_slide, except: [:index, :create, :new]

  def index
    @slides = Slide.order_by_newest.paginate page: params[:page], per_page: Settings.def_perpage
  end

  def create 
    @slide = Slide.new slide_params
    @slide.save
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

  def edit; end

  def update
    if @check_update = @slide.update_attributes(slide_params)
      flash[:success] = t ".slide_update_success"
    end
    respond_to do |format|
      format.js
    end
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
