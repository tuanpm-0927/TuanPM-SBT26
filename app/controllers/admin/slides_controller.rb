class Admin::SlidesController < ApplicationController
  before_action :load_slide, except: [:index, :create, :new]

  def index
    @slides = Slide.paginate(page: params[:page], per_page:  Settings.def_perpage)
    authorize @slides
  end

  def create 
    @slide = Slide.new slide_params
    authorize @slide
    params[:slide][:active] = Settings.checkbox_true ? true: false
    if @slide.save
      load_slides
    end
    respond_to do |format|
      format.js
    end
  end

  def new
    @slide = Slide.new
    authorize @slide
    respond_to do |format|
      format.js
    end
  end

  def edit
    authorize @slide
    respond_to do |format|
      format.js
    end
  end

  def update
    authorize @slide
    if @check_update = @slide.update_attributes(slide_params)
      flash[:success] = t ".slide_update_success"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    authorize @slide
    if @slide.destroy
      flash[:success] = t ".delete_success"
      redirect_to admin_slides_path
    end
  end

  private
  def slide_params
    params.require(:slide).permit(:name, :image, :active)
  end

  def load_slide
    @slide = Slide.find_by(id: params[:id])
    unless @slide
      flash.now[:danger] = t ".slide_notfound"
      redirect_to notfound_path
    end
  end

  def load_slides
    @slides = Slide.paginate(page: Settings.def_page, per_page: Settings.def_perpage)
  end
end
