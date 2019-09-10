class Admin::ToursController < ApplicationController
  before_action :load_tour, only: [:edit, :update, :destroy,:show]
  before_action :check_booking_tour, only: :destroy

  def index
    @tours = Tour.order_by_newest.paginate page: params[:page], per_page: Settings.def_perpage
    authorize @tours
  end

  def listtour
    authorize @tour
    @tour_details = @tour.tourdetails
  end

  def new
    @tour = Tour.new
    authorize @tour
    @image = @tour.images.build
  end
  
  def create
    @tour = Tour.new params_tour
    authorize @tour
    if @tour.save
      params[:images][:image_link].each do |image|
        @image_attachment = @tour.images.create!(image_link: image, tour_id: @tour.id)
      end
      redirect_to admin_tours_path
    else
      render :new
    end
  end
  
  def update
    authorize @tour
    if @tour.update_attributes(params_tour)
      flash[:success] = t ".update_success"
      redirect_to admin_tours_path
    else
      render :edit
    end
  end

  def edit
    authorize @tour
  end

  def destroy
    authorize @tour
    check_booking_tour
    if @tour.destroy
      flash[:success] = t ".delete_success"
      redirect_to admin_tours_path
    else
      flash[:success] = t ".delete_failed"
      redirect_to notfound_path
    end
  end

  private
  def check_booking_tour
    unless @tour.is_booking_tour
      flash[:danger] = t ".tour_having_booking"
      redirect_to admin_tours_path
    end
  end

  def params_tour
    params.require(:tour).permit(:title, :address_source, :price, :discount, :price_discount,
      :total_day, :start_days, :content, :category_id, :total_member_max, :images, :description)
  end

  def load_tour
    @tour = Tour.find_by(id: params[:id])
    unless @tour
      redirect_to notfound_path
    end
  end
end
