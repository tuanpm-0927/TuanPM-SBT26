class Admin::ToursController < ApplicationController
  before_action :load_tour, only: [:edit, :update, :destroy]

  def index
    @tours = Tour.orderby.paginate page: params[:page], per_page: Settings.def_perpage
  end

  def new
    @tour = Tour.new
  end
  
  def create
    @tour = Tour.new params_tour
    if @tour.save
      redirect_to admin_tours_path
    else
      render :new
    end
    
  end

  def update
    if @tour.update_attributes(params_tour)
      flash[:success] = t ".update_success"
      redirect_to admin_tours_path
    else
      render :edit
    end
  end

  def edit; end

  def destroy
    if @tour.destroy
      flash[:success] = t ".delete_success"
      redirect_to admin_tours_path
    else
      flash[:success] = t ".delete_failed"
      redirect_to notfound_path
    end
  end

  private
  def params_tour
    params.require(:tour).permit(:title, :address_source, :price, :discount, :price_discount,
      :total_day, :start_days, :content, :category_id, :total_member_max)
  end

  def load_tour
    @tour = Tour.find_by(id: params[:id])
    unless @tour
      redirect_to notfound_path
    end
  end
end
