class Admin::ToursController < ApplicationController
  authorize_resource
  
  before_action :load_tour, only: [:edit, :update, :destroy,:show]
  before_action :check_booking_tour, only: :destroy

  def index
    @q = Tour.ransack(params[:q]) 
    @tours = if params[:q].nil?
      Tour
    else
      @tours = @q.result(distinct: true)
    end.order_by_newest.paginate page: params[:page], per_page: Settings.def_perpage

    authorize @tours
  end

  def listtour
    @tour_details = @tour.tourdetails
  end

  def new
    @tour = Tour.new
    @image = @tour.images.build
  end
  
  def create
    @tour = Tour.new params_tour
    if @tour.save
      params[:images][:image_link].each do |image|
        @image_attachment = @tour.images.create!(image_link: image, tour_id: @tour.id)
      end
      redirect_to admin_tours_path
    else
      flash[:danger] = t ".create_tour_failed"
      render :new
    end
  end
  
  def update
    if @tour.update_attributes(params_tour)
      flash[:success] = t ".update_success"
      redirect_to admin_tours_path
    else
      flash[:danger] = t ".update_tour_failed"
      render :edit
    end
  end

  def edit; end

  def destroy
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
