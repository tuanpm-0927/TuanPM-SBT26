class Admin::CategoriesController < ApplicationController
  authorize_resource

  before_action :load_category, except: [:index, :new, :create]
  before_action :load_categories, only: [:create]

  def index
    @q = Category.ransack(params[:q])  
    @categories = if params[:q].nil?
      Category
    else
      @categories = @q.result(distinct: true)
    end.order_by_newest.paginate page: params[:page], per_page: Settings.def_perpage
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @category = Category.new category_params
    @category.save
    respond_to do |format|
      format.js
    end
  end

  def show; end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @check_update = @category.update_attributes(category_params)
      flash[:success] = t ".category_update_success"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @category.tours.length > 0 and check_tour_booked?@category.tours
      flash[:danger] = t ".have_booking_tour_of_category"
      if @category.destroy
        flash[:success] = t ".delete_success"
      else
        flash[:danger] = t ".delete_failed"
      end
    elsif @category.really_destroy!
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admin_categories_path
  end

  private
  def load_category
    @category = Category.find_by(id: params[:id])
    return if @category
    flash.now[:danger] = t ".category_notfound"
    redirect_to notfound_path
  end

  def load_categories
    @categories = Category.order_by_newest.paginate(page: Settings.def_page, per_page: Settings.def_perpage)
  end

  def category_params
    params.require(:category).permit(:name, :type_post, :image)
  end
  
  def check_tour_booked?tours
    tours.each do |tour|
      if tour.total_booking_tour > 0
        return true
      end
    end
    false
  end
end
