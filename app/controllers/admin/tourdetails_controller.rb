class Admin::TourdetailsController < ApplicationController
  authorize_resource
  
  before_action :load_tour, only: [:edit, :index, :new, :destroy, :create]
  before_action :load_tour_detail, only: [:edit, :update, :destroy]

  def index
    @tourdetails = @tour.tourdetails.paginate(page: params[:page], per_page: Settings.def_perpage)
  end
 
  def new
    @tourdetail = @tour.tourdetails.build
  end

  def create
    @tourdetail = Tourdetail.new params_tour_detail
    if @tourdetail.save
      load_tour
      flash[:success] = t ".create_success"
      redirect_to admin_tour_tourdetails_path(@tour)
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @tourdetail.update_attributes(params_tour_detail)
      flash[:success] = t ".update_success"
      load_tour
      redirect_to admin_tour_tourdetails_path(@tour)
    else
      render :edit
    end
  end

  def destroy
    if @tourdetail.total_current_booking > 0
      flash[:danger] = t ".danger_booking"
      if @tourdetail.destroy
        flash[:success] = t ".delete_success"
      else
        flash[:danger] = t ".delete_failed"
      end
    else
      begin
        ActiveRecord::Base.transaction do
        if @tourdetail.really_destroy!
          flash[:success] = t ".delete_success"
        else
          flash[:danger] = t ".delete_failed"
        end
        rescue ActiveRecord::RecordInvalid => exception
          flash[:danger] = t ".error_system"
        end
      end
    end
    redirect_to admin_tour_tourdetails_path(@tour)
  end
  
  private 
  def params_tour_detail
    params.require(:tourdetail).permit(:day_start, :tour_id, :total_booking)
  end
  
  def load_tour
    @tour = Tour.find_by(id: params[:tour_id])
    unless @tour
      flash[:danger] = t ".tour_notfound"
      redirect_to notfound_path
    end
  end

  def load_tour_detail
    @tourdetail = Tourdetail.find_by(id: params[:id])
    unless @tourdetail
      flash[:danger] = t ".tourdetail_notfound"
      redirect_to notfound_path
    end
  end
end
